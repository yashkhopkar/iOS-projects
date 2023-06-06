//
//  RestockViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-23.
//

import UIKit

class RestockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var productsArr = (UIApplication.shared.delegate as! AppDelegate).products
    
    var selectedProduct: Product?
    
    @IBOutlet weak var restockAmtTxt: UITextField!
    
    @IBOutlet weak var restockTableView: UITableView!
    
    
    @IBAction func restockBtn(_ sender: Any) {
        guard let selectedProduct = selectedProduct else {
            showAlert(message: "Please select a product to restock.")
            restockAmtTxt.text = ""
            return
        }
        
        guard let restockAmount = restockAmtTxt.text, !restockAmount.isEmpty, Int(restockAmount) != nil else {
            showAlert(message: "Please enter a valid integer restock amount.")
            restockAmtTxt.text = ""
            return
        }
        
        let selectedProductLastQty = selectedProduct.getQuantity()
        let intQty = Int(restockAmtTxt.text!)
        selectedProduct.setQuantity(selectedProductLastQty + intQty!)
        restockTableView.reloadData()
        restockAmtTxt.text = ""
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        restockTableView.dataSource = self
        restockTableView.delegate = self
        restockTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restockCell", for: indexPath)
        let product = productsArr[indexPath.row]
        cell.textLabel?.text = product.getName()
        cell.detailTextLabel?.text = String(product.getQuantity())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productsArr[indexPath.row]
        selectedProduct = product
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
