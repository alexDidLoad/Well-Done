//
//  CustomTimerButtons.swift
//  Well Done
//
//  Created by Alexander Ha on 12/3/20.
//

import UIKit

class CustomTimerButton: UIButton {
    
    init(withImage image: String, isHidden: Bool) {
        super.init(frame: .zero)
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        tintColor = .white
        setImage(UIImage(systemName: image), for: .normal)
        imageView?.setDimensions(height: 60, width: 60)
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
