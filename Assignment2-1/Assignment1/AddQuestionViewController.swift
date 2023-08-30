//
//  AddQuestionViewController.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-06-06.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    var filePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "questionBank.plist")
    
    @IBOutlet weak var addQuestion: UITextField!
    
    @IBOutlet weak var addAnswer: UITextField!
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let indexPath = selectedIndexPath {
            print("Selected row: \(indexPath.row)")
            addQuestion.text = questionBankList[indexPath.row].question
            addAnswer.text = questionBankList[indexPath.row].answer
        }
    }
    
    
    @IBAction func saveQuestionBtn(_ sender: UIButton) {
        guard let questionText = addQuestion.text, !questionText.isEmpty else {
            displayAlert(message: "Please enter a question.")
            return
        }
        
        guard let answerText = addAnswer.text, !answerText.isEmpty else {
            displayAlert(message: "Please enter an answer.")
            return
        }
        
        if let indexPath = selectedIndexPath {
            questionBankList[indexPath.row].question = questionText
            questionBankList[indexPath.row].answer = answerText
            saveToFile()
        } else {
            questionBankList.append(QuestionBank(question: questionText, answer: answerText))
            saveToFile()
        }
        navigationController?.popViewController(animated: true)
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
