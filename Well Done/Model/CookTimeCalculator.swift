//
//  CookTimeCalculator.swift
//  Well Done
//
//  Created by Alexander Ha on 11/22/20.
//

import UIKit

struct CookTimeCalculator {
    
    public func calculateCookTime(for protein: String!, method: String!, doneness: String!) -> Double {
        
        var cookTime = 0.0

        //Steak cook times for each method of cooking
        if protein == "steak" {
            switch method {
            case "pan":
                switch doneness {
                case "Rare":
                    cookTime = 180
                case "Medium Rare":
                    cookTime = 240
                default:
                    cookTime = 300
                }
            case "oven":
                switch doneness {
                case "Rare":
                    cookTime = 600
                case "Medium Rare":
                    cookTime = 840
                default:
                    cookTime = 1260
                }
            default:
                switch doneness {
                case "Well Done":
                    cookTime = 2400
                default:
                    cookTime = 2400
                }
            }
            //chicken cook times for each method of cooking
        } else if protein == "chicken" {
            switch method {
            case "pan":
                switch doneness {
                case "Medium":
                    cookTime = 240
                case "Medium Well":
                    cookTime = 300
                default:
                    cookTime = 360
                }
            case "oven":
                switch doneness {
                case "Medium":
                    cookTime = 960
                case "Medium Well":
                    cookTime = 1020
                default:
                    cookTime = 1080
                }
            default:
                switch doneness {
                case "Medium":
                    cookTime = 840
                case "Medium Well":
                    cookTime = 900
                default:
                    cookTime = 960
                }
            }
            //fish cook times for each method of cooking
        } else if protein == "fish" {
            switch method {
            case "pan":
                switch doneness {
                case "Medium":
                    cookTime = 300
                case "Medium Well":
                    cookTime = 360
                default:
                    cookTime = 420
                }
            case "oven":
                switch doneness {
                case "Medium":
                    cookTime = 720
                case "Medium Well":
                    cookTime = 780
                default:
                    cookTime = 840
                }
            default:
                switch doneness {
                case "Medium":
                    cookTime = 330
                case "Medium Well":
                    cookTime = 390
                default:
                    cookTime = 420
                }
            }
        } else {
            //egg method boil times
            switch method {
            case "boil" :
                switch doneness {
                case "Soft Boil":
                    cookTime = 360
                case "Medium Boil":
                    cookTime = 420
                default:
                    cookTime = 720
                }
            default:
                break
            }
        }
        return cookTime
    }
}
