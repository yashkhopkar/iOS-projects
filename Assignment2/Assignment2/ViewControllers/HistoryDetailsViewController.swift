//
//  HistoryDetailsViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-23.
//

import UIKit

class HistoryDetailsViewController: UIViewController {
    
    var history: History!
    
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product.text = history.getName()
        quantity.text = String(history.getQuantity())
        timestamp.text = history.getTimeStamp()
        amount.text = String(history.gettotalAmount())

        // Do any additional setup after loading the view.
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
