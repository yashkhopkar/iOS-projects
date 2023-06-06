//
//  CalculatorBrain.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-02-03.
//

import Foundation

var displayValue: [String] = []

class CalculatorBrain {
    
    func doCalculatorOperation()->String{
        var result: String
        var foundOperand: Int = 0
        var operand: String = ""
        if displayValue.isEmpty {
            result = "Error"
            return result;
        }
        for (index, value) in displayValue.enumerated() {
            if index == 0 || index == displayValue.count - 1 {
                if value == "+" || value == "-" || value == "*" || value == "/" {
                    result = "Error"
                    return result
                }
            }
        }
        
        for (value) in displayValue {
            if value == "+" || value == "-" || value == "*" || value == "/" {
                foundOperand += 1
                operand = value
            }
        }
        
        if foundOperand > 1 {
            result = "Error"
            return result
        }
        
        let splitArray = displayValue.split { $0 == "+" || $0 == "-" || $0 == "*" || $0 == "/" }
    
        let strNo1 = splitArray[0].joined()
        let strNo2 = splitArray[1].joined()
        
        let no1: Double = Double(strNo1)!
        let no2: Double = Double(strNo2)!
        
        var ans: Double = 0
        var strAns: String = ""
        
        if operand == "+" {
            ans = no1 + no2
            strAns = String(Int(ans))
        }else if operand == "-" {
            ans = no1 - no2
            strAns = String(Int(ans))
        }else if operand == "*" {
            ans = no1 * no2
            strAns = String(Int(ans))
        }else if operand == "/" {
            ans = no1 / no2
            strAns = String(ans)
        }
        
        
        return strAns
    }
    
}
