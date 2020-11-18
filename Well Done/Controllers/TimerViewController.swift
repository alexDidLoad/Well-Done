//
//  TimerViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/17/20.
//

import UIKit

class TimerViewController: UIViewController, CAAnimationDelegate {
    
    private let shapeLayer = CAShapeLayer()
    private let startButton = UIButton()
    private let oookTimer = Timer()
    private var timerLabel: UILabel!
    
    //create button to start timer
    
    //create button to reset timer
    
    //create pause button
    
    //create button to exit current viewcontroller
    
    //add label to track timer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProgressBar()
        setButtons()
        
        
        
    }
    
    
     func setTimer() {
        
        
        
    }
    
    private func setProgressBar() {
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        //draw circle
        let center = view.center
        
        //create track layer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.4052485824, green: 1, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        //        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func setButtons() {
        
        startButton.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        startButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 20)
        startButton.layer.cornerRadius = 30
        startButton.layer.masksToBounds = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        //add targets
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        
    }
    
    @objc private func startTimer() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "basic")
        startButton.isHidden = true
        
        animation.delegate = self
        
        //find way to show startButton once animation is complete
    }
    
   func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag == true {
            startButton.isHidden = false
        }
        
    }
    
    
    
    
    
    
    
}
