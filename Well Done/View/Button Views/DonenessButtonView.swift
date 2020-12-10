//
//  DonenessButtonView.swift
//  Well Done
//
//  Created by Alexander Ha on 12/9/20.
//

import UIKit

protocol DonenessButtonViewDelegate: class {
    func handleDonenessSelected()
}

class DonenessButtonView: UIView {
    
    //MARK: - UIComponents
    
    private let topButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Rare", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Thin", size: 26)
        button.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        button.layer.borderWidth = 10
        button.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleTopTap), for: .touchUpInside)
        return button
    }()
    
    private let midButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Medium Rare", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Thin", size: 26)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        button.layer.borderWidth = 10
        button.layer.borderColor = #colorLiteral(red: 0.9999362826, green: 0.9020040035, blue: 0.4274116755, alpha: 1)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleMidTap), for: .touchUpInside)
        return button
    }()
    
    private let botButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Well Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Thin", size: 25)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        button.layer.borderWidth = 10
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleBotTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    weak var delegate: DonenessButtonViewDelegate?
    
    private var topLeadingAnchor: NSLayoutConstraint?
    private var topTrailingAnchor: NSLayoutConstraint?
    
    private var midLeadingAnchor: NSLayoutConstraint?
    private var midTrailingAnchor: NSLayoutConstraint?
    
    private var botTopAnchor: NSLayoutConstraint?
    private var botCenterAnchor: NSLayoutConstraint?
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
        PROTEIN.doneness = topButton.currentTitle?.lowercased()
        delegate?.handleDonenessSelected()
        button.liftUp()
    }
    
    @objc func handleMidTap(button: UIButton) {
        PROTEIN.doneness = midButton.currentTitle?.lowercased()
        delegate?.handleDonenessSelected()
        button.liftUp()
    }
    
    @objc func handleBotTap(button: UIButton) {
        PROTEIN.doneness = botButton.currentTitle?.lowercased()
        delegate?.handleDonenessSelected()
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
    
    private func updateLabels() {
        topButton.isHidden = false
        midButton.isHidden = false
        botButton.isHidden = false
        
        if PROTEIN.type == "chicken" || PROTEIN.type == "fish" {
            topButton.setTitle("Medium", for: .normal)
            midButton.setTitle("Medium Well", for: .normal)
            botButton.setTitle("Well Done", for: .normal)
        } else if PROTEIN.type == "egg" {
            topButton.setTitle("Soft Boil", for: .normal)
            midButton.setTitle("Medium Boil", for: .normal)
            botButton.setTitle("Hard Boil", for: .normal)
        } else if PROTEIN.method == "boil"  && PROTEIN.type == "steak"{
            topButton.isHidden = true
            midButton.isHidden = true
            botButton.setTitle("Well Done", for: .normal)
            botButton.layer.borderColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1)
        } else {
            topButton.setTitle("Rare", for: .normal)
            midButton.setTitle("Medium Rare", for: .normal)
            botButton.setTitle("Well Done", for: .normal)
        }
    }
    
    public func animateInDoneness() {
        updateLabels()
        NSLayoutDeactivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
        NSLayoutActivate([topLeadingAnchor, midTrailingAnchor, botCenterAnchor])
        UIView.animate(withDuration: 0.5, delay: 0.8, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.layoutIfNeeded()
        }
    }
    
    public func resetDoneButtons() {
        NSLayoutDeactivate([topLeadingAnchor,midTrailingAnchor,botCenterAnchor])
        NSLayoutActivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
        self.layoutIfNeeded()
    }
}
