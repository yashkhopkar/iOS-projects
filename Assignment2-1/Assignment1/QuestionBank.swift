//
//  QuestionBank.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-06-06.
//

import Foundation

var questionBankList = [QuestionBank]()

class QuestionBank : Codable {
    var question : String
    var answer : String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
}
