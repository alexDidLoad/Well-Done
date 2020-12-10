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
        iv.tintColor = #colorLiteral(red: 0.4614635429, green: 0.2202478027, blue: 0.2029526682, alpha: 1)
        iv.setDimensions(height: 18, width: 18)
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "QUICK TIP"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4614635429, green: 0.2202478027, blue: 0.2029526682, alpha: 1)
        label.font = UIFont(name: "SFProText-Heavy", size: 12)
        label.setHeight(height: 30)
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "BODY TEXT HERE"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4614635429, green: 0.2202478027, blue: 0.2029526682, alpha: 1)
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
        
        self.backgroundColor = #colorLiteral(red: 0.9952659011, green: 0.8474430442, blue: 0.7168733478, alpha: 1)
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
            switch PROTEIN.type {
            case "steak":
                bodyLabel.text = "Flip it, add butter and run the timer one more time!🔥"
            case "chicken":
                bodyLabel.text = "Flip it and run the timer one more time!🔥"
            case "fish":
                bodyLabel.text = "Flip it, turn off the heat and run the timer again!🐟"
            default:
                bodyLabel.text = "Hmm...This is a problem 🧐"
            }
        case "oven":
            bodyLabel.text = "Set the oven at 365°F and leave it alone.🤫"
        case "boil":
            switch PROTEIN.type {
            case "egg":
                bodyLabel.text = "Make sure the water is at a rolling boil.🌡"
            default:
                bodyLabel.text = "For pot roast, simmer it on medium-low.🥘"
            }
        default:
            bodyLabel.text = "Make sure the oil is at 350°F, and fry in batches!👍🏻"
        }
    }
    
}
