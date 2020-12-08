//
//  CustomButton.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit

class CustomButton: UIButton {
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
    let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        adjustsImageWhenHighlighted = false
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = 140 / 2
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

