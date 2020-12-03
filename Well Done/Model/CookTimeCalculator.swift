//
//  CookTimeCalculator.swift
//  Well Done
//
//  Created by Alexander Ha on 11/22/20.
//

import UIKit

struct CookTimeCalculator {
    
    var cookTime = 0.0
    
    public mutating func calculateCookTime(for protein: String, method: String, doneness: String) -> Double {
        if protein == "steak" {
            calculateSteak(method: method, doneness: doneness)
        } else if protein == "chicken" {
            calculateChicken(method: method, doneness: doneness)
        } else if protein == "fish" {
            calculateFish(method: method, doneness: doneness)
        } else {
            calculateEgg(method: method, doneness: doneness)
        }
        return cookTime
    }
    
    //MARK: - Helpers
    
    private mutating func calculateSteak(method: String, doneness: String) {
        switch method {
        case "pan":
            switch doneness {
            case "rare":
                cookTime = 180
            case "medium rare":
                cookTime = 240
            default:
                cookTime = 300
            }
        case "oven":
            switch doneness {
            case "rare":
                cookTime = 600
            case "medium rare":
                cookTime = 840
            default:
                cookTime = 1260
            }
        default:
            switch doneness {
            case "well done":
                cookTime = 2400
            default:
                cookTime = 2400
            }
        }
    }
    
    private mutating func calculateChicken(method: String, doneness: String) {
        switch method {
        case "pan":
            switch doneness {
            case "medium":
                cookTime = 240
            case "medium well":
                cookTime = 300
            default:
                cookTime = 360
            }
        case "oven":
            switch doneness {
            case "medium":
                cookTime = 960
            case "medium well":
                cookTime = 1020
            default:
                cookTime = 1080
            }
        default:
            switch doneness {
            case "medium":
                cookTime = 840
            case "medium well":
                cookTime = 900
            default:
                cookTime = 960
            }
        }
    }
    
    private mutating func calculateFish(method: String, doneness: String) {
        switch method {
        case "pan":
            switch doneness {
            case "medium":
                cookTime = 300
            case "medium mell":
                cookTime = 360
            default:
                cookTime = 420
            }
        case "oven":
            switch doneness {
            case "medium":
                cookTime = 720
            case "medium well":
                cookTime = 780
            default:
                cookTime = 840
            }
        default:
            switch doneness {
            case "medium":
                cookTime = 330
            case "medium well":
                cookTime = 390
            default:
                cookTime = 420
            }
        }
    }
    
    private mutating func calculateEgg(method: String, doneness: String) {
        switch method {
        case "boil" :
            switch doneness {
            case "soft boil":
                cookTime = 360
            case "medium boil":
                cookTime = 420
            default:
                cookTime = 720
            }
        default:
            break
        }
    }
}

