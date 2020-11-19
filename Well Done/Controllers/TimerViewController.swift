//
//  TimerViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/17/20.
//

import UIKit

class TimerViewController: UIViewController, CAAnimationDelegate {
    
    //animation layer objects
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    //button and labels
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let exitButton = UIButton()
    private var timerLabel = UILabel()
    
    //timer objects
    private var cookTimer = Timer()
    private var endTime: Date?
    private var timeLeft: TimeInterval = 5
    
    //create button to exit current viewcontroller
    
    //add label to track timer
    
    
    //MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawTrackLayer()
        configureButtons()
        configureTimer()
        
    }
    
    //MARK: - Configure Methods
    
    func configureTimer() {
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        timerLabel.text = timeLeft.time
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont(name: "SFProText-Medium", size: 50)
        timerLabel.backgroundColor = .white
        timerLabel.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        timerLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        timerLabel.layer.borderWidth = 2
        timerLabel.layer.cornerRadius = 20
        timerLabel.clipsToBounds = true
        
        timerLabel.isHidden = false
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 60),
            timerLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
        
    }
    
    private func drawTrackLayer() {
        //draw circle
        let center = view.center
        
        //create track layer
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(trackLayer)
    }
    
    private func drawProgressLayer() {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0.4052485824, green: 1, blue: 0, alpha: 1).cgColor
        progressLayer.lineWidth = 20
        progressLayer.lineCap = .round
        progressLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(progressLayer)
    }
    
    
    private func configureButtons() {
        
        startButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        startButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        startButton.layer.cornerRadius = 30
        startButton.layer.masksToBounds = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.isHidden = false
        
        resetButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        resetButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        resetButton.layer.cornerRadius = 30
        resetButton.layer.masksToBounds = true
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.isHidden = true
        
        //add targets
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
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
        ])
    }
    
    //MARK: - @Obj-c Methods
    
    @objc private func startTimer() {
        
        drawProgressLayer()
        configureAnimation()
        endTime = Date().addingTimeInterval(timeLeft)
        cookTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        startButton.isHidden = true
        resetButton.isHidden = false
        
    }
    
    @objc private func resetTimer() {
        
        cookTimer.invalidate()
        timeLeft = 5
        timerLabel.text = timeLeft.time
        
        progressLayer.removeFromSuperlayer()
        
        resetButton.isHidden = true
        startButton.isHidden = false
    }
    
    @objc private func updateTime() {
        
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        } else {
            timerLabel.text = "00:00"
            cookTimer.invalidate()
        }
        
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
    
}

//MARK: - Extensions

extension TimeInterval {
    
    var time: String {
        return String(format: "%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))))
    }
    
}
