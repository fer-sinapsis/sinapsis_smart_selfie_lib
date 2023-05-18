//
//  SelfieData.swift
//  smart_selfie_ai_model
//
//  Created by Sudarshan Chakra on 23/12/21.
//

import Foundation

struct SelfieData {
    var age: Double
    var gender: String
    var weight: Double
    var height: Double
    
    func toDictionary() -> [String: Any] {
        let bmi = (self.weight / (self.height * self.height)) * 10000
        
        return ["age": self.age.roundToDecimal(2),
                "weight": self.weight.roundToDecimal(2),
                "gender": self.gender,
                "height": self.height.roundToDecimal(2),
                "bmi": bmi.roundToDecimal(2),
               ];
    }
}


extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
