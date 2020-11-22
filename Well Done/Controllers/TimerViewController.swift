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
    private var timeLeft: TimeInterval = 0
    
    //cook times
    public var cookTime: Double!
    
    
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
        
        timerLabel.isHidden = false
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    private func drawTrackLayer() {
        //draw circle
        let center = view.center
        
        //create track layer
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(white: 1.0, alpha: 0.5).cgColor
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
        
        exitButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        exitButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        exitButton.setTitle("EXIT", for: .normal)
        exitButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        exitButton.layer.cornerRadius = 30
        exitButton.layer.masksToBounds = false
        exitButton.layer.shadowColor = shadowColor
        exitButton.layer.shadowOffset = shadowOffSet
        exitButton.layer.shadowOpacity = shadowOpacity
        exitButton.layer.shadowRadius = shadowRadius
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.isHidden = false
        
        //add targets
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitView), for: .touchUpInside)
        
        view.addSubview(exitButton)
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
            exitButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 60),
            exitButton.widthAnchor.constraint(equalToConstant: 150)
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
        timeLeft = cookTime
        timerLabel.text = timeLeft.time
        
        progressLayer.removeFromSuperlayer()
        
        resetButton.isHidden = true
        startButton.isHidden = false
    }
    
    @objc private func updateTime() {
        
        timeLeft = cookTime
        
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        } else {
            timerLabel.text = "00:00"
            cookTimer.invalidate()
            
            let ac = UIAlertController(title: "Food's Ready", message: "\nDon't Overcook it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    @objc private func exitView() {
        
        dismiss(animated: true)

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