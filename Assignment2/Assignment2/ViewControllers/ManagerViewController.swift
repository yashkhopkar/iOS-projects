//
//  ManagerViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-23.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistory" {
            
            let historyVC = segue.destination as! HistoryTableViewController
        }else if segue.identifier == "toRestock" {
            let restockVC = segue.destination as! RestockViewController
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
