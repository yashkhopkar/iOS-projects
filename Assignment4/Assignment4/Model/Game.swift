//
//  Game.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-08-12.
//

import Foundation

var favouriteGames: [String] = []

class Game: Codable {
    var id: Int?
    var name: String?
    var released: String?
    var background_image: URL?
    var rating: Double?
    var esrb_rating: ESRB?
    
    init(_id: Int, _name : String, _released : String, _background_image: URL, _rating:Double, _esrb: ESRB){
        id = _id
        name = _name
        released = _released
        background_image = _background_image
        rating = _rating
        esrb_rating = _esrb
    }
}

class GameList: Codable {
    var results: [Game] = []
}

class ESRB: Codable {
    var name: String?
    
    init(_name: String){
        name = _name
    }
}
