//
//  QuickTipView.swift
//  Well Done
//
//  Created by Alexander Ha on 12/7/20.
//

import UIKit

class QuickTipView: UIView {
    
    //MARK: - Properties
    
    private let lightningIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bolt.fill")
        iv.tintColor = #colorLiteral(red: 0.07448554784, green: 0.2862593234, blue: 0.3056544662, alpha: 1)
        iv.setDimensions(height: 18, width: 18)
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "QUICK TIP"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.07448554784, green: 0.2862593234, blue: 0.3056544662, alpha: 1)
        label.font = UIFont(name: "SFProText-Heavy", size: 12)
        label.setHeight(height: 30)
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "BODY TEXT HERE"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.07448554784, green: 0.2862593234, blue: 0.3056544662, alpha: 1)
        label.font = UIFont(name: "SFProText-Medium", size: 12)
        label.setHeight(height: 30)
        return label
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        updateBodyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Helpers
    
    private func configureUI() {
        
        self.backgroundColor = #colorLiteral(red: 0.7857559323, green: 0.9420768023, blue: 0.9264129996, alpha: 1)
        self.setHeight(height: 70)
        layer.cornerRadius = 10
        addSubview(lightningIcon)
        lightningIcon.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             paddingTop: 10,
                             paddingLeading: 10)
        addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor,
                          leading: lightningIcon.trailingAnchor,
                          paddingLeading: 5)
        addSubview(bodyLabel)
        bodyLabel.anchor(top: titleLabel.bottomAnchor)
        bodyLabel.centerX(inView: self)
    }
    
    private func updateBodyLabel() {
        switch PROTEIN.method {
        case "pan":
            bodyLabel.text = "Flip, reset the timer and its finished!🔥"
        case "oven":
            bodyLabel.text = "Set the oven at 365°F and leave it alone.🤫"
        case "boil":
            bodyLabel.text = "What tip do you need? It's done when it's done 🥸"
        default:
            bodyLabel.text = "No Tips for you. You're on your own, Good luck 😈"
        }
    }
    
}
