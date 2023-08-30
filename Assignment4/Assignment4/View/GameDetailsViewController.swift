//
//  GameDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-08-12.
//

import UIKit
import CoreData

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var gameRelased: UILabel!
    
    @IBOutlet weak var gameRating: UILabel!
    
    @IBOutlet weak var ersb: UILabel!
    
    var game: Game!
    
    var dbManager = CoreDataManager.shared
    
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
    
    
    @IBAction func addToFavs(_ sender: UIButton) {
        dbManager.createFavGame(_name: game.name!, _url: game.background_image!)
        //performSegue(withIdentifier: "toFavouritesView", sender: self)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toFavouritesView" {
            let favVC = segue.destination as! FavouritesTableViewController
            //favVC.gameName = game.name
        }
    }
    

}
