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
    
    //MARK: - UI Components
    
    private let playButton: CustomTimerButton = {
        let button = CustomTimerButton(withImage: "play.circle.fill", isHidden: false)
        button.setDimensions(height: 60, width: 60)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return button
    }()
    
    private let pauseButton: CustomTimerButton = {
        let button = CustomTimerButton(withImage: "pause.circle", isHidden: true)
        button.setDimensions(height: 60, width: 60)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.07448554784, green: 0.2862593234, blue: 0.3056544662, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Medium", size: 60)
        label.setDimensions(height: 221, width: 221)
        label.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        label.layer.cornerRadius = 221 / 2
        label.layer.masksToBounds = true
        return label
    }()
    
    private let finishedTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SFProText-Ultralight", size: 18)
        return label
    }()
    
    private let bellIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bell")
        iv.tintColor = .black
        return iv
    }()
    
    private let progressLayer: CustomShapeLayer = {
        let layer = CustomShapeLayer()
        layer.strokeColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1).withAlphaComponent(0.8).cgColor
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
        animation.toValue = 1.0
        animation.speed = 1.0
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
    //MARK: - Properties
    
    private var timer = Timer()
    private var timeLeft: TimeInterval = 0
    private var cookTime: Double!
    private var savedTime: Double!
    private var date: Date?
    private let calendar = Calendar.current
    
    private var calculator = CookTimeCalculator()
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private let notification = NotificationCenter.default
    
    private var audioPlayer: AVAudioPlayer!
    private var soundEffect: AVAudioPlayer!
    
    private var isRunning: Bool = false
    private var hasPaused: Bool = false
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addNotificationObserver()
    }
    
    deinit {
        notification.removeObserver(self)
    }
    
    //MARK: - Selectors
    
    @objc func handlePlay(button: UIButton) {
        if hasPaused == true {
            savedTime = Double(date!.timeIntervalSinceNow - timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            if timeLeft > 0 {
                notificationAlert()
            }
            resumeAnimation()
        } else {
            startTime()
            notificationAlert()
            isRunning = true
        }
        playButton.isHidden = true
        pauseButton.isHidden = false
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleReset(button: UIButton) {
        stopTime()
        button.liftUp()
    }
    
    @objc func handlePause(button: UIButton) {
        pauseAnimation()
        timer.invalidate()
        userNotificationCenter.removeAllPendingNotificationRequests()
        hasPaused = true
        playButton.isHidden = false
        pauseButton.isHidden = true
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleCancel(button: UIButton) {
        exitTimer()
        button.liftUp()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    
    @objc private func updateTime() {
        alertUser()
    }
    
    @objc func willEnterForeground() {
        if isRunning {
            pulsingLayer.add(pulsingAnimation, forKey: "pulsing")
        }
    }
    
    //MARK: - Notifications
    
    private func addNotificationObserver() {
        notification.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func notificationAlert() {
        let content = UNMutableNotificationContent()
        content.title = "Food is ready!"
        content.body = "Don't let it burn!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "Well Done"]
        content.sound = UNNotificationSound.default
        
        var trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeLeft, repeats: false) {
            didSet { trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeLeft, repeats: false)}
        }
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        userNotificationCenter.add(request)
    }
    //MARK: - Audio Player
    
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
    
    private func buttonSoundEffect() {
        guard let url = Bundle.main.url(forResource: "buttonTock", withExtension: ".mp3") else { return }
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            soundEffect.play()
        } catch {
            print("DEBUG: Failed to play sound effect: \(error.localizedDescription)")
        }
    }
    //MARK: - Helpers
    
    private func startTime() {
        finishedTimeLabel.text = calculateEndTime()
        view.layer.addSublayer(progressLayer)
        progressAnimation.duration = timeLeft
        progressLayer.speed = 1.0
        progressLayer.add(progressAnimation, forKey: "stroke")
        pulsingLayer.speed = 1.0
        pulsingLayer.add(pulsingAnimation, forKey: "pulsing")
        date = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func stopTime() {
        timer.invalidate()
        timeLeft = cookTime
        timerLabel.text = timeLeft.time
        progressLayer.removeFromSuperlayer()
        pulsingLayer.removeAnimation(forKey: "pulsing")
        isRunning = false
        hasPaused = false
        pauseButton.isHidden = true
        playButton.isHidden = false
        userNotificationCenter.removeAllPendingNotificationRequests()
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
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func alertUser() {
        if hasPaused && timeLeft > 0 {
            timeLeft = date!.timeIntervalSinceNow + (-savedTime)
            timerLabel.text = timeLeft.time
        } else if timeLeft > 0 {
            timeLeft = date?.timeIntervalSinceNow ?? 0
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
    
    private func calculateEndTime() -> String {
        let date = Date()
        var hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let calculatedMinutes = minute + Int(cookTime / 60)
        
        if calculatedMinutes > 60 {
            hour += 1
            if calculatedMinutes % 60 > 10 {
                finishedTimeLabel.text = "\(hour):\(calculatedMinutes % 60)"
            } else if calculatedMinutes % 60 < 10 {
                finishedTimeLabel.text = "\(hour):0\(calculatedMinutes % 60)"
            }
        } else if calculatedMinutes == 60 {
            finishedTimeLabel.text = "\(hour):00"
        } else if calculatedMinutes < 10 {
            finishedTimeLabel.text = "\(hour):0\(calculatedMinutes)"
        } else {
            finishedTimeLabel.text = "\(hour):\(calculatedMinutes)"
        }
        guard let finishedTimeLabelText = finishedTimeLabel.text else { return ""}
        return finishedTimeLabelText
    }
    
    private func resumeAnimation() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
        pulsingLayer.speed = 1.0
        pulsingLayer.add(pulsingAnimation, forKey: "pulsing")
    }
    
    private func pauseAnimation() {
        let pausedTime: CFTimeInterval = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
        pulsingLayer.speed = 0.0
    }
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
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
        
        let startAngle = 1.5 * CGFloat.pi
        let center = view.center
        let pulsingPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let circularPath = UIBezierPath(arcCenter: center, radius: 118, startAngle: startAngle, endAngle: startAngle + 2 * CGFloat.pi , clockwise: true)
        
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
        
        finishedTimeLabel.text = calculateEndTime()
        timerLabel.addSubview(finishedTimeLabel)
        finishedTimeLabel.centerX(inView: timerLabel, constant: 4)
        finishedTimeLabel.centerY(inView: timerLabel, constant: 50)
        
        timerLabel.addSubview(bellIcon)
        bellIcon.setDimensions(height: 15, width: 15)
        bellIcon.anchor(top: finishedTimeLabel.topAnchor,
                        trailing: finishedTimeLabel.leadingAnchor,
                        paddingTop: 4,
                        paddingTrailing: 2)
        
        let bottomView = configureBottomView()
        view.addSubview(bottomView)
        bottomView.centerX(inView: view)
        bottomView.anchor(top: timerLabel.bottomAnchor, paddingTop: 50)
        
        let stack = UIStackView(arrangedSubviews: [playButton, pauseButton])
        stack.axis = .vertical
        bottomView.addSubview(stack)
        stack.centerX(inView: bottomView)
        stack.anchor(top: bottomView.topAnchor, paddingTop: 20)
        stack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(resetButton)
        resetButton.setHeight(height: 28)
        resetButton.anchor(top: stack.topAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           paddingTop: 64,
                           paddingTrailing: 16)
        
        view.addSubview(cancelButton)
        cancelButton.setHeight(height: 28)
        cancelButton.anchor(top: stack.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           paddingTop: 64,
                           paddingLeading: 16)
    }
    
}

