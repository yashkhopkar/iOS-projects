//
//  JsonManager.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-04-18.
//

import Foundation

class JsonManager{
    
    static var shared = JsonManager()
    func fromJsonDataToGamesArray(jsonData : Data)->[Game]{
        var gamesArray = [Game]()
        let decoder = JSONDecoder()
        do {
            let gameList = try decoder.decode(GameList.self, from: jsonData)
            for game in gameList.results {
                if game.id == nil {
                    game.id = 0
                }
                if game.name == nil {
                    game.name = "No Data Available"
                }
                if game.released == nil {
                    game.released = "No Data Available"
                }
                if game.background_image == nil {
                    game.background_image = URL(string: "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg")
                }
                if game.rating == nil {
                    game.rating = 0.0
                }
                if(game.esrb_rating == nil){
                    var ersb = ESRB(_name: "N/A")
                    game.esrb_rating = ersb
                }
                gamesArray.append(Game(_id: game.id!, _name: game.name!, _released: game.released!, _background_image: game.background_image!, _rating: game.rating!, _esrb: game.esrb_rating!))
            }
        }
        catch{
            print(error)
        }
        return gamesArray
    }
}
