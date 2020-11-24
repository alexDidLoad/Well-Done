//
//  TimerViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/17/20.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, CAAnimationDelegate {
    
    //animation layer objects
    private let progressLayer = CAShapeLayer()
    private var pulsatingLayer: CAShapeLayer!
    private let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    //button and labels
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let backButton = UIButton()
    private var timerLabel = UILabel()
    private var subtitleLabel = UILabel()
    
    //timer objects
    private var cookTimer = Timer()
    private var endTime: Date?
    private var timeLeft: TimeInterval = 0
    
    //cook times
    public var cookTime: Double!
    
    //boolean properties
    private var isRunning: Bool = false
    
    //Alarm
    private var audioPlayer: AVAudioPlayer!
    
    
    //MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawTrackLayer()
        configureButtons()
        configureTimer()
        
    }
    
    //MARK: - Configure Methods
    
    func configureTimer() {
        
        timeLeft = cookTime
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        timerLabel.text = timeLeft.time
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont(name: "SFProText-Ultralight", size: 60)
        timerLabel.backgroundColor = view.backgroundColor
        timerLabel.frame = CGRect(x: 0, y: 0, width: 230, height: 230)
        timerLabel.layer.cornerRadius = timerLabel.frame.width / 2
        timerLabel.layer.masksToBounds = true
        timerLabel.isHidden = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerLabel)
        
        
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 230),
            timerLabel.widthAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    private func drawTrackLayer() {
        
        let trackLayer = CAShapeLayer()
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 1
        pulsatingLayer.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1).withAlphaComponent(0.9).cgColor
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round
        pulsatingLayer.position = center
        pulsatingLayer.zPosition = -1
        pulsatingLayer.frame = view.bounds
        view.layer.addSublayer(pulsatingLayer)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.7).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
    }
    
    private func drawProgressLayer() {
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0.6173558769, green: 0.9874898816, blue: 0.2694684731, alpha: 1).cgColor
        progressLayer.lineWidth = 20
        progressLayer.lineCap = .round
        progressLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(progressLayer)
        
    }
    
    
    private func configureButtons() {
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        startButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        startButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        startButton.layer.cornerRadius = 30
        startButton.layer.masksToBounds = false
        startButton.layer.shadowColor = shadowColor
        startButton.layer.shadowOffset = shadowOffSet
        startButton.layer.shadowOpacity = shadowOpacity
        startButton.layer.shadowRadius = shadowRadius
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.isHidden = false
        
        resetButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        resetButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        resetButton.layer.cornerRadius = 30
        resetButton.layer.masksToBounds = false
        resetButton.layer.shadowColor = shadowColor
        resetButton.layer.shadowOffset = shadowOffSet
        resetButton.layer.shadowOpacity = shadowOpacity
        resetButton.layer.shadowRadius = shadowRadius
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.isHidden = true
        
        backButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        backButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        backButton.setTitle("BACK", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        backButton.layer.cornerRadius = 30
        backButton.layer.masksToBounds = false
        backButton.layer.shadowColor = shadowColor
        backButton.layer.shadowOffset = shadowOffSet
        backButton.layer.shadowOpacity = shadowOpacity
        backButton.layer.shadowRadius = shadowRadius
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isHidden = false
        
        //add targets
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(exitView), for: .touchUpInside)
        
        view.addSubview(backButton)
        view.addSubview(startButton)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 60),
            resetButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    //MARK: - @Obj-c Methods
    
    @objc private func startTimer() {
        
        drawProgressLayer()
        configureAnimation()
        animatePulsatingLayer()
        
        endTime = Date().addingTimeInterval(timeLeft)
        cookTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        isRunning = true
        startButton.isHidden = true
        resetButton.isHidden = false
        
        resetButton.bounce()
    }
    
    @objc private func resetTimer() {
        
        cookTimer.invalidate()
        timeLeft = cookTime
        timerLabel.text = timeLeft.time
        
        progressLayer.removeFromSuperlayer()
        pulsatingLayer.removeAnimation(forKey: "pulsing")
        
        isRunning = false
        resetButton.isHidden = true
        startButton.isHidden = false
        startButton.bounce()
    }
    
    @objc private func updateTime() {
        
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        } else {
            timerLabel.text = "00:00"
            AudioServicesPlaySystemSound(1005)
            pulsatingLayer.removeAnimation(forKey: "pulsing")
            cookTimer.invalidate()
            
            let ac = UIAlertController(title: "Food's Ready", message: "\nDon't Overcook it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc private func exitView() {
        
        if timerLabel.text == "00:00" || isRunning == false {
            dismiss(animated: true)
        } else {
            let ac = UIAlertController(title: "Are you sure?", message: "Going back will reset the timer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in self?.dismiss(animated: true)}))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        backButton.bounce()
    }
    
    //MARK: - Supporting methods
    
    private func configureAnimation() {
        
        //animation values
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = timeLeft
        animation.speed = 0.8
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: nil)
        
        animation.delegate = self
    }
    
    private func animatePulsatingLayer() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.3
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
        
    }
    
}






