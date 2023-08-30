//
//  QuestionBankTableViewController.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-06-06.
//

import UIKit

class QuestionBankTableViewController: UITableViewController {
    
    var uDefaults = UserDefaults.standard
    
    var filePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "questionBank.plist")
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let dataFromFile = try Data(contentsOf: filePath!)
            let decoder = PropertyListDecoder()
            questionBankList = try decoder.decode([QuestionBank].self, from: dataFromFile)
            tableView.reloadData()
        } catch {
            
            print (error)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questionBankList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = questionBankList[indexPath.row].question
        cell.detailTextLabel?.text = questionBankList[indexPath.row].answer
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "showAddQtVC", sender: self)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            questionBankList.remove(at: indexPath.row)
            saveToFile()
            tableView.reloadData()
        }
    }
    
    func saveToFile(){
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(questionBankList)
            try data.write(to: self.filePath!)
        } catch{
            print (error)
        }
        
    }
    
    
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
        if segue.identifier == "showAddQtVC", let destination = segue.destination as? AddQuestionViewController, let indexPath = selectedIndexPath {
            destination.selectedIndexPath = indexPath
        }
    }
    
    
}
