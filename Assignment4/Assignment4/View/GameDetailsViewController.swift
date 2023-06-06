//
//  GameDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-04-20.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var gameRelased: UILabel!
    
    @IBOutlet weak var gameRating: UILabel!
    
    @IBOutlet weak var ersb: UILabel!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameName.text = game.name
        gameRelased.text = game.released
        ersb.text = game.esrb_rating?.name
        if let rating = game.rating {
               gameRating.text = String(rating)
           } else {
               gameRating.text = "N/A"
           }
        if let imageURL = game.background_image {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.gameImage.image = image
                    }
                }
            }.resume()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toFavouritesView" {
            let favVC = segue.destination as! FavouritesTableViewController
            favVC.gameName = game.name
        }
    }
    

}
