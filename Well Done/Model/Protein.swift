//
//  Protein.swift
//  Well Done
//
//  Created by Alexander Ha on 11/29/20.
//

import UIKit

struct Protein {
    
    var type: String!
    var method: String!
    var doneness: String!
    
    init(type: String? = "", method: String? = "", doneness: String? = "") {
      
        self.type = type
        self.method = method
        self.doneness = doneness
    
    }
}
