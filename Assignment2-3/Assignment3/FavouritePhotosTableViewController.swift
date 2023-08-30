//
//  FavouritePhotosTableViewController.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-25.
//

import UIKit

class FavouritePhotosTableViewController: UITableViewController {
    
    var favouritePhotos = [FavPhoto]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.shared.getAllFavoritePhotos { result in
            switch result {
            case .success(let photos):
                self.favouritePhotos = photos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch favorite photos: \(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouritePhotos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let photo = favouritePhotos[indexPath.row]
        cell.textLabel?.text = "ID: \(photo.id ?? 0)"
        cell.detailTextLabel?.text = "Rover: \(photo.rover ?? "")"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFavPhotoDetails" {
            let detailsVC = segue.destination as! FavouritePhotoDetailsViewController
            let selectedRow = tableView.indexPathForSelectedRow!.row
            detailsVC.photo = self.favouritePhotos[selectedRow]
        }
    }
    

}
