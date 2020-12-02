//
//  CustomButton.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit

class CustomButton: UIButton {
    
    init(imageName: String? = nil) {
        super.init(frame: .zero)
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        
        guard let imageName = imageName else { return }
        setImage(UIImage(named: imageName), for: .normal)
        adjustsImageWhenHighlighted = false
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = 150 / 2
        layer.borderColor = #colorLiteral(red: 1, green: 0.4196327627, blue: 0.4195776284, alpha: 1)
        layer.borderWidth = 1
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

