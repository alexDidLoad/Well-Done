//
//  ViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit
import UserNotifications

class ProteinViewController: UIViewController {
    
    //MARK: - UI Components
    
    private let steakButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "meat"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(steakButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let chickenButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "chicken"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(chickenButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let fishButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "fish"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 35)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(fishButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let eggButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "egg"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 35)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(eggButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let methodOneButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "pan"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 29)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleTopTap), for: .touchUpInside)
        return button
    }()
    
    private let methodTwoButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "oven"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
//        button.addTarget(self, action: #selector(handleMidTap), for: .touchUpInside)
        return button
    }()
    
    private let methodThreeButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "fryer"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 17, left: 25, bottom: 17, right: 17)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
//        button.addTarget(self, action: #selector(handleBotTap), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select Protein"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Medium", size: 36)
        return label
    }()
    
    private lazy var topStack = UIStackView(arrangedSubviews: [steakButton, chickenButton])
    private lazy var midStack = UIStackView(arrangedSubviews: [fishButton, eggButton])
    var topLeadingAnchor: NSLayoutConstraint?
    var topTrailingAnchor: NSLayoutConstraint?
 
    var midLeadingAnchor: NSLayoutConstraint?
    var midTrailingAnchor: NSLayoutConstraint?
    
    var botTopAnchor: NSLayoutConstraint?
    var botCenterAnchor: NSLayoutConstraint?
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerForNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //MARK: - Selectors
    
    @objc func steakButtonPressed() {
//        pushTo(viewController: MethodViewController(), withProtein: "steak", button: steakButton)
        view.fade(out: [topStack, midStack])
        animate()
    }
    
    @objc func chickenButtonPressed() {
//        pushTo(viewController: MethodViewController(), withProtein: "chicken", button: chickenButton)
       
    }
    
    @objc func fishButtonPressed() {
        pushTo(viewController: MethodViewController(), withProtein: "fish", button: fishButton)
    }
    
    @objc func eggButtonPressed() {
        pushTo(viewController: MethodViewController(), withProtein: "egg", button: eggButton)
    }
    
    @objc func handleTopTap() {
        
        view.fade(out: [methodOneButton, methodTwoButton, methodThreeButton])
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    //MARK: - UserNotification
    
    private func registerForNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print("DEBUG: Error in requesting authorization: \(error.localizedDescription)")
            }
            if granted {
                print("DEBUG: Notification Authorization was granted")
            } else {
                print("DEBUG: Notification Authorization was denied")
            }
        }
    }
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        configureNavBar(withTitle: "Well Done", prefersLargeTitle: true)
        navigationItem.backButtonTitle = "Select Protein"

//        let topStack = UIStackView(arrangedSubviews: [steakButton, chickenButton])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        view.addSubview(topStack)
        topStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        paddingTop: 35,
                        paddingLeading: 25,
                        paddingTrailing: 25)
        
//        let midStack = UIStackView(arrangedSubviews: [fishButton, eggButton])
        midStack.axis = .horizontal
        midStack.distribution = .equalSpacing
        view.addSubview(midStack)
        midStack.anchor(top: topStack.bottomAnchor,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        paddingTop: 50,
                        paddingLeading: 25,
                        paddingTrailing: 25)
        
        view.addSubview(methodThreeButton)
        methodThreeButton.centerX(inView: view)
        botTopAnchor = methodThreeButton.topAnchor.constraint(equalTo: view.bottomAnchor)
        botTopAnchor?.isActive = true
        botCenterAnchor = methodThreeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        botCenterAnchor?.isActive = false
        
        
        let bottomView = configureBottomView()
        view.addSubview(bottomView)
        bottomView.anchor(top: midStack.bottomAnchor, paddingTop: 50)
        bottomView.centerX(inView: view)
        
        bottomView.addSubview(label)
        label.centerX(inView: bottomView)
        label.anchor(top: bottomView.topAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     paddingTop: 50)
        
        view.addSubview(methodOneButton)
        methodOneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 35)
        topLeadingAnchor = methodOneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        topLeadingAnchor?.isActive = false
        topTrailingAnchor = methodOneButton.trailingAnchor.constraint(equalTo: view.leadingAnchor)
        topTrailingAnchor?.isActive = true
        
        view.addSubview(methodTwoButton)
        methodTwoButton.anchor(top: methodOneButton.topAnchor)
        midLeadingAnchor = methodTwoButton.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        midLeadingAnchor?.isActive = true
        midTrailingAnchor = methodTwoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        midTrailingAnchor?.isActive = false
    }
    
    func animate() {
        
        NSLayoutDeactivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
        NSLayoutActivate([topLeadingAnchor, midTrailingAnchor, botCenterAnchor])
//        topLeadingAnchor?.isActive = true
//        midTrailingAnchor?.isActive = true
//
        UIView.animate(withDuration: 0.5, delay: 1.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.label.text = "Select Method"
        }
        
    }
    
}
