//
//  ViewController.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-01-27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberTouched(_ sender: UIButton) {
        if let number = sender.titleLabel?.text{
            displayValue.append(number)
            let stringRepresentation = displayValue.joined(separator:" ")
            calculatorScreen.text = stringRepresentation
        }
    }
    
    @IBAction func clearTouched(_ sender: UIButton) {
        displayValue.removeAll()
        calculatorScreen.text = ""
    }
    
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if let number = sender.titleLabel?.text{
            displayValue.append(number)
            let stringRepresentation = displayValue.joined(separator:" ")
            calculatorScreen.text = stringRepresentation
        }
    }
    
    @IBAction func equalsTouched(_ sender: UIButton) {
        let calculate = CalculatorBrain()
        let ans: String = calculate.doCalculatorOperation()
        if let number = sender.titleLabel?.text{
            displayValue.append(number)
            displayValue.append(ans)
            let stringRepresentation = displayValue.joined(separator:" ")
            calculatorScreen.text = stringRepresentation
        }
    }
    
    @IBOutlet weak var calculatorScreen: UILabel!
    
    
    
}

