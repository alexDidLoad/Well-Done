////
////  CookViewController.swift
////  Well Done
////
////  Created by Alexander Ha on 11/17/20.
////

import UIKit

class DonenessViewController: UIViewController {
    
    //MARK: - Properties
    
    private var stack = UIStackView()
    private var stackTopAnchor: NSLayoutConstraint!
    
    private let topButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Rare", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 26)
        button.backgroundColor = #colorLiteral(red: 0.3534811724, green: 0.9519462339, blue: 0.916274381, alpha: 1)
        button.layer.borderWidth = 0
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleTopTap), for: .touchUpInside)
        return button
    }()
    
    private let midButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Medium Rare", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 26)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = #colorLiteral(red: 0.9999362826, green: 0.9020040035, blue: 0.4274116755, alpha: 1)
        button.layer.borderWidth = 0
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleMidTap), for: .touchUpInside)
        return button
    }()
    
    private let botButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Well Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 26)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1)
        button.layer.borderWidth = 0
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleBotTap), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select Doneness"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Light", size: 36)
        label.numberOfLines = 0
        return label
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateLabels()
    }
    //MARK: - Selectors
    
    @objc func handleTopTap() {
        pushTo(viewController: TimerViewController(),withProtein: PROTEIN.type, withCookMethod: PROTEIN.method, withDoneness: topButton.currentTitle?.lowercased(), button: topButton)
    }
    
    @objc func handleMidTap() {
        pushTo(viewController: TimerViewController(),withProtein: PROTEIN.type, withCookMethod: PROTEIN.method, withDoneness: midButton.currentTitle?.lowercased(), button: midButton)
    }
    
    @objc func handleBotTap() {
        pushTo(viewController: TimerViewController(),withProtein: PROTEIN.type, withCookMethod: PROTEIN.method, withDoneness: botButton.currentTitle?.lowercased(), button: botButton)
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        stack = UIStackView(arrangedSubviews: [topButton, midButton, botButton])
        stack.axis = .vertical
        stack.spacing = 35
        view.addSubview(stack)
        stack.centerX(inView: view)
        stackTopAnchor = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 12)
        stackTopAnchor.isActive = true
        
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: stack.bottomAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func updateLabels() {
        if PROTEIN.type == "chicken" || PROTEIN.type == "fish" {
            topButton.setTitle("Medium", for: .normal)
            midButton.setTitle("Medium Well", for: .normal)
            botButton.setTitle("Well Done", for: .normal)
        } else if PROTEIN.type == "egg" {
            topButton.setTitle("Soft Boil", for: .normal)
            midButton.setTitle("Medium Boil", for: .normal)
            botButton.setTitle("Hard Boil", for: .normal)
        } else if PROTEIN.method == "boil" {
            stackTopAnchor.isActive = false
            stack.centerY(inView: view, constant: -20)
            stack.centerX(inView: view)
            topButton.isHidden = true
            midButton.setTitle("Well Done", for: .normal)
            midButton.backgroundColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1)
            botButton.isHidden = true
        }
    }
}
