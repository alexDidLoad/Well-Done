//
//  ProteinButtonView.swift
//  Well Done
//
//  Created by Alexander Ha on 12/9/20.
//

import UIKit

protocol ProteinButtonViewDelegate: class {
    func handleProteinSelected()
}

class ProteinButtonView: UIView {
    
    //MARK: - UIComponents
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
    //MARK: - Properties
    
    weak var delegate: ProteinButtonViewDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    
    @objc func steakButtonPressed(button: UIButton) {
        PROTEIN.type = "steak"
        delegate?.handleProteinSelected()
        button.liftUp()
    }
    
    @objc func chickenButtonPressed(button: UIButton) {
        PROTEIN.type = "chicken"
        delegate?.handleProteinSelected()
        button.liftUp()
    }
    
    @objc func fishButtonPressed(button: UIButton) {
        PROTEIN.type = "fish"
        delegate?.handleProteinSelected()
        button.liftUp()
    }
    
    @objc func eggButtonPressed(button: UIButton) {
        PROTEIN.type = "egg"
        delegate?.handleProteinSelected()
        button.liftUp()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        let topStack = UIStackView(arrangedSubviews: [steakButton, chickenButton])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        addSubview(topStack)
        topStack.anchor(top: self.topAnchor,
                        leading: self.leadingAnchor,
                        trailing: self.trailingAnchor,
                        paddingTop: 30,
                        paddingLeading: 25,
                        paddingTrailing: 25)
        
        let midStack = UIStackView(arrangedSubviews: [fishButton, eggButton])
        midStack.axis = .horizontal
        midStack.distribution = .equalSpacing
        addSubview(midStack)
        midStack.anchor(top: topStack.bottomAnchor,
                        leading: self.leadingAnchor,
                        trailing: self.trailingAnchor,
                        paddingTop: 40,
                        paddingLeading: 25,
                        paddingTrailing: 25)
                      
    }
    
    
//    public func resetProteinButtons() {
//        NSLayoutActivate([topTrailingAnchor, midLeadingAnchor, botTopAnchor])
//        NSLayoutDeactivate([topLeadingAnchor,midTrailingAnchor,botCenterAnchor])
//        self.layoutIfNeeded()
//    }
    
}
