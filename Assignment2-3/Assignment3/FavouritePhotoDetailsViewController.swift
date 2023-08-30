//
//  FavouritePhotoDetailsViewController.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-31.
//

import UIKit

class FavouritePhotoDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var rover: UILabel!
    
    var photo: FavPhoto?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photo = photo {
            id.text = "ID: \(photo.id ?? 0)"
            date.text = "Date: \(photo.earth_date ?? "")"
            rover.text = "Rover: \(photo.rover ?? "")"
            if let url = photo.img_src {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.image.image = image
                        }
                    }
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
