//
//  CustomButton.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit

class CustomButton: UIButton {

    var imageName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        self.layer.masksToBounds = false
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffSet
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = 0.5 * self.frame.size.width
//        if imageName != nil {
//            self.setImage(UIImage(named: imageName!), for: .normal)
//        }
        self.backgroundColor = UIColor.white
        
    }
}

