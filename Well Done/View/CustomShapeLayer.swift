//
//  ProgressLayer.swift
//  Well Done
//
//  Created by Alexander Ha on 12/3/20.
//

import UIKit


class CustomShapeLayer: CAShapeLayer {
    
    override init() {
        super.init()
        
        lineWidth = 15
        lineCap = .round
        fillColor = UIColor.clear.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
