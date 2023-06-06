//
//  History.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-23.
//

import Foundation

class History {
    
    private var name : String
    private var quantity : Int
    private var timeStamp: String
    private var totalAmount: Double
    
    init(name: String, quantity: Int, timeStamp: String, totalAmount: Double) {
        self.name = name
        self.quantity = quantity
        self.timeStamp = timeStamp
        self.totalAmount = totalAmount
    }
    
    func getName() -> String{
        return name
    }
    
    func getQuantity() -> Int{
        return quantity
    }
    
    func getTimeStamp() -> String{
        return timeStamp
    }
    
    func gettotalAmount() -> Double{
        return totalAmount
    }
}


extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy|HH:mm"
        return dateFormatter.string(from: self)
    }
}
