////
////  TimerViewController.swift
////  Well Done
////
////  Created by Alexander Ha on 11/17/20.
////

import UIKit
import UserNotifications
import AVFoundation

let userNotificationCenter = UNUserNotificationCenter.current()

class TimerViewController: UIViewController {
    
    //MARK: - Properties
    
    private var timerView = TimerView()
    
    private let pulsingNotification = NotificationCenter.default
    
    private var audioPlayer: AVAudioPlayer!
    
    private var isRunning: Bool = false
    private var hasPaused: Bool = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        PROTEIN.type = nil
        PROTEIN.method = nil
        PROTEIN.doneness = nil
    }
    
    deinit {
        pulsingNotification.removeObserver(self)
    }
    //MARK: - Selectors
    
    @objc private func updateTime() {
        if hasPaused && timerView.timeLeft > 0 {
            timerView.timeLeft = timerView.date!.timeIntervalSinceNow + (-timerView.savedTime)
            timerView.timerLabel.text = timerView.timeLeft.time
        } else if timerView.timeLeft > 0 {
            timerView.timeLeft = timerView.date?.timeIntervalSinceNow ?? 0
            timerView.timerLabel.text = timerView.timeLeft.time
        } else {
            timerView.timerLabel.text = "00:00"
            playAlarm()
            timerView.pulsingLayer.removeAnimation(forKey: pulsing)
            timerView.timer.invalidate()
            
            let ac = UIAlertController(title: "Food's Ready", message: "\nDon't overcook it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] _ in
                self?.audioPlayer?.stop()
            }))
            present(ac, animated: true)
        }
    }
    
    @objc func willEnterForeground() {
        if isRunning {
            timerView.pulsingLayer.add(timerView.pulsingAnimation, forKey: pulsing)
        }
    }
    //MARK: - Notifications
    
    private func addNotificationObserver() {
        pulsingNotification.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func notificationAlert() {
        let content = UNMutableNotificationContent()
        content.title = "Food is ready!"
        content.body = "Don't let it burn!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "Well Done"]
        content.sound = UNNotificationSound.default
        
        var trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval:
                                                                                            timerView.timeLeft,
                                                                                           repeats: false) {
            didSet { trigger = UNTimeIntervalNotificationTrigger(timeInterval: timerView.timeLeft,
                                                                 repeats: false)} }
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        userNotificationCenter.add(request)
    }
    //MARK: - Helpers
    
    private func exitTimer() {
        if timerView.timerLabel.text == "00:00" || isRunning == false {
            navigationController?.popToRootViewController(animated: true)
        } else {
            let ac = UIAlertController(title: "Are you sure?", message: "Going back will reset the timer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
                                        self?.navigationController?.popToRootViewController(animated: true)}
            ))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func playAlarm() {
        guard let url = Bundle.main.url(forResource: "marimba", withExtension: ".wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = audioPlayer else { return }
            player.play()
        } catch {
            print("DEBUG: Failed to play alarm: \(error.localizedDescription)")
        }
    }

    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9925742745, green: 0.9858585, blue: 0.8622567654, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "\(PROTEIN.type.capitalized) | \(PROTEIN.method.capitalized) | \(PROTEIN.doneness.capitalized)"
        navigationItem.hidesBackButton = true
        
        let quickTipView = QuickTipView(frame: .zero)
        view.addSubview(quickTipView)
        quickTipView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.safeAreaLayoutGuide.leadingAnchor,
                            trailing: view.safeAreaLayoutGuide.trailingAnchor,
                            paddingTop: 20,
                            paddingLeading: 15,
                            paddingTrailing: 15)
        quickTipView.centerX(inView: view)
        
        timerView.cookTime = timerView.calculator.calculateCookTime(for: PROTEIN.type,
                                                                    method: PROTEIN.method,
                                                                    doneness: PROTEIN.doneness)
        timerView.timeLeft = timerView.cookTime
        timerView.timerLabel.text = timerView.timeLeft.time
        view.addSubview(timerView)
        timerView.centerX(inView: view)
        timerView.centerY(inView: view)
        
        let bottomTimerView = BottomTimerView()
        bottomTimerView.delegate = self
        view.addSubview(bottomTimerView)
        bottomTimerView.centerX(inView: view)
        bottomTimerView.anchor(top: timerView.bottomAnchor, paddingTop: 180)
    }
}
//MARK: - BottomTimerViewDelegate

extension TimerViewController: BottomTimerViewDelegate {
    
    func handlePlay() {
        
        if hasPaused == true {
            timerView.savedTime = Double(timerView.date!.timeIntervalSinceNow - timerView.timeLeft)
            timerView.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            if timerView.timeLeft > 0 {
                notificationAlert()
            }
            timerView.resumeAnimation()
        } else {
            timerView.startTime()
            timerView.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            notificationAlert()
            isRunning = true
        }
    }
    
    func handleReset() {
        timerView.timer.invalidate()
        timerView.timeLeft = timerView.calculator.calculateCookTime(for: PROTEIN.type,
                                                                    method: PROTEIN.method,
                                                                    doneness: PROTEIN.doneness)
        timerView.timerLabel.text = timerView.timeLeft.time
        timerView.progressLayer.removeFromSuperlayer()
        timerView.pulsingLayer.removeAnimation(forKey: pulsing)
        isRunning = false
        hasPaused = false
    }
    
    func handlePause() {
        timerView.pauseAnimation()
        timerView.timer.invalidate()
        userNotificationCenter.removeAllPendingNotificationRequests()
        hasPaused = true
    }
    
    func handleCancel() {
        exitTimer()
    }
}

