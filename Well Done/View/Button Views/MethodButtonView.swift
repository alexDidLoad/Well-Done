//
//  MethodButtonView.swift
//  Well Done
//
//  Created by Alexander Ha on 12/9/20.
//

import UIKit

protocol MethodButtonViewDelegate: class {
    func handleMethodSelected()
}

class MethodButtonView: UIView {
    
    //MARK: - UIComponents
    private lazy var topButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "pan"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 29)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleTopTap), for: .touchUpInside)
        return button
    }()
    private lazy var midButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "oven"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleMidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var botButton: CustomButton = {
        let button = CustomButton()
        button.setImage(UIImage(named: "fryer"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.imageEdgeInsets = UIEdgeInsets(top: 17, left: 25, bottom: 17, right: 17)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleBotTap), for: .touchUpInside)
        return button
    }()
    
    private var topLeadingAnchor: NSLayoutConstraint?
    private var topTrailingAnchor: NSLayoutConstraint?
    
    private var midLeadingAnchor: NSLayoutConstraint?
    private var midTrailingAnchor: NSLayoutConstraint?
    
    private var botTopAnchor: NSLayoutConstraint?
    private var botCenterAnchor: NSLayoutConstraint?
    
    //MARK: - Properties
    
    weak var delegate: MethodButtonViewDelegate?
    
    private var topMethod: String? = "pan"
    private var midMethod: String? = "oven"
    private var botMethod: String? = "fryer"
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    
    @objc func handleTopTap(button: UIButton) {
        PROTEIN.method = topMethod
        delegate?.handleMethodSelected()
        button.liftUp()
    }
    
    @objc func handleMidTap(button: UIButton) {
        PROTEIN.method = midMethod
        delegate?.handleMethodSelected()
        button.liftUp()
    }
    
    @objc func handleBotTap(button: UIButton) {
        PROTEIN.method = botMethod
        delegate?.handleMethodSelected()
        button.liftUp()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    //MARK: - Helpers
    
    private func configureUI() {
        
        addSubview(topButton)
        topButton.anchor(top: self.topAnchor, paddingTop: 30)
        topLeadingAnchor = topButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25)
        topLeadingAnchor?.isActive = false
        topTrailingAnchor = topButton.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -25)
        topTrailingAnchor?.isActive = true
        
        addSubview(midButton)
        midButton.anchor(top: self.topAnchor, paddingTop: 30)
        midLeadingAnchor = midButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 25)
        midLeadingAnchor?.isActive = true
        midTrailingAnchor = midButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        midTrailingAnchor?.isActive = false
        
        addSubview(botButton)
        botButton.centerX(inView: self)
        botTopAnchor = botButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        botTopAnchor?.isActive = true
        botCenterAnchor = botButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 85)
        botCenterAnchor?.isActive = false
    }
    
    private func updateImage() {
        topButton.isHidden = false
        midButton.isHidden = false
        botButton.isHidden = false
        
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
            topButton.isHidden = true
            midButton.isHidden = true
            botButton.setImage(UIImage(named: "boil"), for: .normal)
            botMethod = "boil"
        }
    }
    
    public func animateInMethods() {
        updateImage()
        NSLayoutDeactivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
        NSLayoutActivate([topLeadingAnchor, midTrailingAnchor, botCenterAnchor])
        UIView.animate(withDuration: 0.5, delay: 0.8, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.layoutIfNeeded()
        }
    }
    
    public func resetMethodButtons() {
        NSLayoutDeactivate([topLeadingAnchor,midTrailingAnchor,botCenterAnchor])
        NSLayoutActivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
        self.layoutIfNeeded()
    }
}



