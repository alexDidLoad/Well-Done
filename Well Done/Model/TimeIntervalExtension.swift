//
//  TimeIntervalExtension.swift
//  Well Done
//
//  Created by Alexander Ha on 11/23/20.
//

import UIKit

extension TimeInterval {
    
    public var time: String {
        return String(format: "%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))))
    }
    
}
