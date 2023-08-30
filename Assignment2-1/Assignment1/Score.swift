//
//  Score.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-06-08.
//

import Foundation

var scoreObj = Score(average: 0.0, attempts: 0, totalScore: 0)

class Score : Codable {
    var average: Double = 0.0
    var attempts: Int = 0
    var totalScore : Int = 0
    
    init(average: Double, attempts: Int, totalScore: Int) {
        self.average = average
        self.attempts = attempts
        self.totalScore = totalScore
    }
    
}
