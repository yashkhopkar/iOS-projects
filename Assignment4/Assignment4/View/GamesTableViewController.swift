//
//  GamesTableViewController.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-04-19.
//

import UIKit

class GamesTableViewController: UITableViewController,UISearchBarDelegate {
    
    var allGamesFromAPI = [Game]()
    
    @IBOutlet weak var gamesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let urlString = "https://api.rawg.io/api/games?key=7667728f97f742c290305acf9d1d7617"
        
        NetworkingManager.shared.getAPIData(url: urlString) { result in
         
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                    self.allGamesFromAPI = [Game]()
                    self.tableView.reloadData()
                    break
                    
                case .success(let data):
                    
                    self.allGamesFromAPI =   JsonManager.shared.fromJsonDataToGamesArray(jsonData: data)
                    self.tableView.reloadData()
                    break
                    
                }
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
        if !allGamesFromAPI.isEmpty {
            return allGamesFromAPI.count
        }
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        if !allGamesFromAPI.isEmpty {
            cell.textLabel?.text = allGamesFromAPI[indexPath.row].name
        }else{
            cell.textLabel?.text = "Sorry, no games to dispay!"
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let yearRegex = #"^\d{4}$"#
    
        if searchText.count == 4{
            if let _ = searchText.range(of: yearRegex, options: .regularExpression) {
                let urlString = "https://api.rawg.io/api/games?key=7667728f97f742c290305acf9d1d7617&dates="+searchText+"-01-01,"+searchText+"-12-31&ordering=-added"

                NetworkingManager.shared.getAPIData(url: urlString) { result in
                 
                    DispatchQueue.main.async {
                        switch result{
                        case .failure(let error):
                            print(error)
                            self.allGamesFromAPI = [Game]()
                            self.tableView.reloadData()
                            break
                            
                        case .success(let data):
                            
                            self.allGamesFromAPI =   JsonManager.shared.fromJsonDataToGamesArray(jsonData: data)
                            self.tableView.reloadData()
                            break
                            
                        }
                    }
                   
                }
            } else {
                print("Invalid year")
            }
        }else if searchText.count > 2 {
            let urlString = "https://api.rawg.io/api/games?key=7667728f97f742c290305acf9d1d7617&search=" + searchText + "&search_exact=true"

            NetworkingManager.shared.getAPIData(url: urlString) { result in
             
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                        self.allGamesFromAPI = [Game]()
                        self.tableView.reloadData()
                        break
                        
                    case .success(let data):
                        
                        self.allGamesFromAPI =   JsonManager.shared.fromJsonDataToGamesArray(jsonData: data)
                        self.tableView.reloadData()
                        break
                        
                    }
                }
               
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let game = self.allGamesFromAPI[indexPath.row]
//        self.performSegue(withIdentifier: "toGameDetails", sender: self)
//    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toGameDetails" {
            let gameDetVC = segue.destination as! GameDetailsViewController
            let selectedRow = tableView.indexPathForSelectedRow!.row
            gameDetVC.game = self.allGamesFromAPI[selectedRow]
        }
    }


}
