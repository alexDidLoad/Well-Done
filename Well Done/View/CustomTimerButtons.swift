//
//  CustomTimerButtons.swift
//  Well Done
//
//  Created by Alexander Ha on 12/3/20.
//

import UIKit

class CustomTimerButton: UIButton {
    
    init(withTitle title: String, withBackgroundColor color: UIColor, isHidden: Bool) {
        super.init(frame: .zero)
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "SFProText-Light", size: 20)
        layer.cornerRadius = 30
        layer.borderWidth = 5
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = isHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
