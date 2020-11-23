//
//  AnimationExtensions.swift
//  Well Done
//
//  Created by Alexander Ha on 11/23/20.
//

import UIKit

extension UIView {
    
    public func bounce() {
        
        UIView.animate(withDuration: 0.08) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.08) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}


