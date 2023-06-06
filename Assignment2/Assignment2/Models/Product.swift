//
//  Product.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-19.
//

import Foundation

class Product {
    
    private var name : String
    private var quantity : Int
    private var price: Double
    
    init(name: String, quantity: Int, price: Double) {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
    
    func getName() -> String {
        return name
    }
    
    func setName(_ newName: String) {
        name = newName
    }
    
    func getQuantity() -> Int {
        return quantity
    }
    
    func setQuantity(_ newQuantity: Int) {
        quantity = newQuantity
    }
    
    func getPrice() -> Double {
        return price
    }
    
    func setPrice(_ newPrice: Double) {
        price = newPrice
    }
}
