////
////  TimerViewController.swift
////  Well Done
////
////  Created by Alexander Ha on 11/17/20.
////

import UIKit
import UserNotifications
import AVFoundation

class TimerViewController: UIViewController {
    
    //MARK: - Properties
    
    private let startButton: CustomTimerButton = {
        let button = CustomTimerButton(withTitle: "START", withBackgroundColor: #colorLiteral(red: 0.9999362826, green: 0.9020040035, blue: 0.4274116755, alpha: 1), isHidden: false)
        button.setDimensions(height: 60, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleStartPressed), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: CustomTimerButton = {
        let button = CustomTimerButton(withTitle: "RESET", withBackgroundColor: #colorLiteral(red: 0.9999362826, green: 0.9020040035, blue: 0.4274116755, alpha: 1), isHidden: true)
        button.setDimensions(height: 60, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleResetPressed), for: .touchUpInside)
        return button
    }()
    
    private let backButton: CustomTimerButton = {
        let button = CustomTimerButton(withTitle: "BACK", withBackgroundColor: #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1), isHidden: false)
        button.setDimensions(height: 60, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleBackPressed), for: .touchUpInside)
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "nil"
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Ultralight", size: 60)
        label.setDimensions(height: 221, width: 221)
        label.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        label.layer.cornerRadius = 221 / 2
        label.layer.masksToBounds = true
        return label
    }()
    
    private let progressLayer: CustomShapeLayer = {
        let layer = CustomShapeLayer()
        layer.strokeColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1).cgColor
        layer.zPosition = 1
        return layer
    }()
    
    private let trackLayer: CustomShapeLayer = {
        let layer = CustomShapeLayer()
        layer.strokeColor = UIColor.white.withAlphaComponent(0.7).cgColor
        layer.zPosition = 0
        return layer
    }()
    
    private let pulsingLayer: CustomShapeLayer = {
        let layer = CustomShapeLayer()
        layer.strokeColor = UIColor.clear.cgColor
        layer.fillColor = #colorLiteral(red: 0.305575788, green: 0.8039663434, blue: 0.7685286403, alpha: 1).cgColor
        layer.zPosition = -1
        return layer
    }()
    
    private let progressAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.speed = 0.8
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }()
    
    private let pulsingAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.2
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        return animation
    }()
    
    private var timer = Timer()
    private var timeLeft: TimeInterval = 0
    private var cookTime: Double!
    private var endTime: Date?
    
    private var calculator = CookTimeCalculator()
    private var isRunning: Bool? = false
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private var audioPlayer: AVAudioPlayer!
    private var soundEffect: AVAudioPlayer!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    //MARK: - Selectors
    
    @objc func handleStartPressed(button: UIButton) {
        startTime()
        notificationAlert()
        isRunning?.toggle()
        startButton.isHidden = true
        resetButton.isHidden = false
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleResetPressed(button: UIButton) {
        reset()
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleBackPressed(button: UIButton) {
        exitTimer()
        button.liftUp()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    
    @objc private func updateTime() {
        alertUser()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        navigationItem.title = "\(PROTEIN.type.capitalized) | \(PROTEIN.method.capitalized) | \(PROTEIN.doneness.capitalized)"
        navigationItem.hidesBackButton = true
        
        let center = view.center
        let pulsingPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let circularPath = UIBezierPath(arcCenter: center, radius: 118, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        progressLayer.path = circularPath.cgPath
        trackLayer.path = circularPath.cgPath
        view.layer.addSublayer(trackLayer)
        
        pulsingLayer.path = pulsingPath.cgPath
        pulsingLayer.position = center
        pulsingLayer.frame = view.bounds
        view.layer.addSublayer(pulsingLayer)
        
        cookTime = calculator.calculateCookTime(for: PROTEIN.type, method: PROTEIN.method, doneness: PROTEIN.doneness)
        timeLeft = cookTime
        timerLabel.text = timeLeft.time
        view.addSubview(timerLabel)
        timerLabel.centerX(inView: view)
        timerLabel.centerY(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [startButton, resetButton, backButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: timerLabel.bottomAnchor, paddingTop: 65)
    }
    
    private func startTime() {
        view.layer.addSublayer(progressLayer)
        progressAnimation.duration = timeLeft
        progressLayer.add(progressAnimation, forKey: "stroke")
        pulsingLayer.add(pulsingAnimation, forKey: "pulsing")
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func reset() {
        timer.invalidate()
        timeLeft = cookTime
        timerLabel.text = timeLeft.time
        progressLayer.removeFromSuperlayer()
        pulsingLayer.removeAnimation(forKey: "pulsing")
        isRunning = false
        resetButton.isHidden = true
        startButton.isHidden = false
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func exitTimer() {
        if timerLabel.text == "00:00" || isRunning == false {
            navigationController?.popToRootViewController(animated: true)
        } else {
            let ac = UIAlertController(title: "Are you sure?", message: "Going back will reset the timer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
                                        self?.navigationController?.popToRootViewController(animated: true)}
            ))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func notificationAlert() {
        let content = UNMutableNotificationContent()
        content.title = "Food is ready!"
        content.body = "Don't let it burn!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "Well Done"]
        content.sound = UNNotificationSound.default
        
        let interval = TimeInterval(cookTime)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    private func alertUser() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        } else {
            timerLabel.text = "00:00"
            playAlarm()
            pulsingLayer.removeAnimation(forKey: "pulsing")
            timer.invalidate()
            
            let ac = UIAlertController(title: "Food's Ready", message: "\nDon't overcook it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] _ in
                self?.audioPlayer?.stop()
            }))
            present(ac, animated: true)
        }
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
            print(error.localizedDescription)
        }
    }
    
    private func buttonSoundEffect() {
        guard let url = Bundle.main.url(forResource: "buttonTock", withExtension: ".mp3") else { return }
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            soundEffect.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
   
    
}
