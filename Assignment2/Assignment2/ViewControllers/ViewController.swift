//
//  ViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-19.
//

import UIKit

var historyArr : [History] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var displayVal: [String] = []
    var selectedProductPrice: Double = 0.00
    var selectedProduct: Product?
    
    
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    
    @IBAction func numberBtnTapped(_ sender: UIButton) {
        if typeLabel.text! == "Type" {
            let alert = UIAlertController(title: "Error", message: "You have to select an item and provide a quantity", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }else {
            if let number = sender.titleLabel?.text{
                displayVal.append(number)
                let stringRepresentation = displayVal.joined(separator:" ")
                let calcRep = displayVal.joined()
                let totalQuantity = Double(calcRep)!
                quantityLabel.text = stringRepresentation
                let totalPrice : Double = Double(selectedProductPrice) * totalQuantity
                totalPriceLabel.text = String(totalPrice)
            }
        }
    }
    
    
    
    @IBAction func buyBtnTapped(_ sender: Any) {
        if quantityLabel.text! == "Quantity" {
            let alert = UIAlertController(title: "Error", message: "You have to select an item and provide a quantity", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }else {
            let name = typeLabel.text!
            let q = quantityLabel.text!
            let q1 = q.replacingOccurrences(of: " ", with: "")
            let quantity = Int(q1)!
            let currentDate = Date()
            let timeStamp = currentDate.toFormattedString()
            let totalAmount = Double(totalPriceLabel.text!)!
            if quantity > (selectedProduct?.getQuantity())! {
                let alert = UIAlertController(title: "Error", message: "You have to select a quantity less than or equal to the quantity in stock", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true)
                quantityLabel.text = "Quantity"
                totalPriceLabel.text = "Total"
                displayVal = []
            } else{
                let historyObj = History(name: name, quantity: quantity, timeStamp: timeStamp, totalAmount: totalAmount)
                historyArr.append(historyObj)
                selectedProduct?.setQuantity((selectedProduct?.getQuantity())! - quantity)
                productsTableView.reloadData()
                quantityLabel.text = "Quantity"
                totalPriceLabel.text = "Total"
                displayVal = []
            }
        }
    }
    
    
    var productsArr = (UIApplication.shared.delegate as! AppDelegate).products
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = productsArr[indexPath.row]
        cell.productName.text = product.getName()
        cell.productCost.text = String(product.getPrice())
        cell.productCost.textColor = UIColor.red
        cell.productQuantity.text = String(product.getQuantity())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productsArr[indexPath.row]
        selectedProductPrice = product.getPrice()
        typeLabel.text = product.getName()
        selectedProduct = product
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toManager" {
            
            let managerVC = segue.destination as! ManagerViewController
        }
    }
    
    
}

