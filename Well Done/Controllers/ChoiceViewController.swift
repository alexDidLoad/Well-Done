//
//  ChoiceViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/15/20.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    //MARK: - Properties
    
    private var stack = UIStackView()
    private var stackTopAnchor: NSLayoutConstraint!
    
    private var topMethod: String? = "pan"
    private var midMethod: String? = "oven"
    private var botMethod: String? = "fryer"
    
    private let topButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "pan"), for: .normal)
        button.setDimensions(height: 150, width: 150)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 29)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleTopTap), for: .touchUpInside)
        return button
    }()
    private let midButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "oven"), for: .normal)
        button.setDimensions(height: 150, width: 150)
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleMidTap), for: .touchUpInside)
        return button
    }()
    private let botButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "fryer"), for: .normal)
        button.setDimensions(height: 150, width: 150)
        button.imageEdgeInsets = UIEdgeInsets(top: 17, left: 25, bottom: 17, right: 17)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleBotTap), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select Method"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Light", size: 36)
        return label
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateImage()
    }
    //MARK: - Selectors
    
    @objc func handleTopTap() {
        pushTo(viewController: CookViewController(), withProtein: PROTEIN.type, withCookMethod: topMethod, button: topButton)
    }
    
    @objc func handleMidTap() {
        pushTo(viewController: CookViewController(), withProtein: PROTEIN.type, withCookMethod: midMethod, button: midButton)
    }
    
    @objc func handleBotTap() {
        pushTo(viewController: CookViewController(), withProtein: PROTEIN.type, withCookMethod: botMethod, button: botButton)
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
   
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = "Select Method"
        
        stack = UIStackView(arrangedSubviews: [topButton, midButton, botButton])
        stack.axis = .vertical
        stack.spacing = 35
        view.addSubview(stack)
        stack.centerX(inView: view)
        stackTopAnchor = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
        stackTopAnchor.isActive = true
        
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: stack.bottomAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    /// Updates button images according to the protein.type
    private func updateImage() {
        if PROTEIN.type == "steak" {
            topButton.setImage(UIImage(named: "pan"), for: .normal)
            midButton.setImage(UIImage(named: "oven"), for: .normal)
            botButton.setImage(UIImage(named: "boil"), for: .normal)
            botButton.imageEdgeInsets = UIEdgeInsets(top: 17, left: 17, bottom: 17, right: 17)
            topMethod = "pan"
            midMethod = "oven"
            botMethod = "boil"
        } else if PROTEIN.type == "chicken" || PROTEIN.type == "fish" {
            topButton.setImage(UIImage(named: "pan"), for: .normal)
            midButton.setImage(UIImage(named: "oven"), for: .normal)
            botButton.setImage(UIImage(named: "fryer"), for: .normal)
            topMethod = "pan"
            midMethod = "oven"
            botMethod = "fryer"
        } else {
            stackTopAnchor.isActive = false
            stack.centerY(inView: view, constant: -20)
            stack.centerX(inView: view)
            topButton.isHidden = true
            midButton.setImage(UIImage(named: "boil"), for: .normal)
            botButton.isHidden = true
            midMethod = "boil"
        }
    }
    
}

