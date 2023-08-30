//
//  UserViewController.swift
//  Assignment1
//
//  Created by Yash Khopkar on 2023-06-06.
//

import UIKit

class UserViewController: UIViewController {
    
    var uDefaults = UserDefaults.standard
    
    var filePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "questionBank.plist")
    
    var filePath2 =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "average.plist")
    
    @IBOutlet weak var quizQtLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var questionCounter : Int = 0
    var quizScore : Int = 0
    var numberOfAttempts : Int = 0
    var average : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        do {
            let dataFromFile = try Data(contentsOf: filePath!)
            let decoder = PropertyListDecoder()
            questionBankList = try decoder.decode([QuestionBank].self, from: dataFromFile)
        } catch {
            print (error)
        }
        
        do {
            let dataFromFile = try Data(contentsOf: filePath2!)
            let decoder = PropertyListDecoder()
            scoreObj = try decoder.decode(Score.self, from: dataFromFile)
            numberOfAttempts = scoreObj.attempts
            average = scoreObj.average
        } catch {
            print (error)
        }
        
        quizQtLabel.text = questionBankList[questionCounter].question
        updateProgressBar()
    }
    
    
    @IBAction func btnTruePressed(_ sender: UIButton) {
        checkQtAnswer(value: "True")
    }
    
    
    @IBAction func btnFalsePressed(_ sender: UIButton) {
        checkQtAnswer(value: "False")
    }
    
    func checkQtAnswer(value: String) {
        if questionBankList[questionCounter].answer == value {
            quizScore += 1
        }
        
        questionCounter += 1
        
        if questionCounter == questionBankList.count {
            updateProgressBar()
            average = saveAvgToFile(score: quizScore, numAttempts: numberOfAttempts+1)
            displayAlert(message: "You scored: \(quizScore) out of \(questionBankList.count). The average is \(average) ")
        } else {
            quizQtLabel.text = questionBankList[questionCounter].question
            updateProgressBar()
        }
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Quiz Complete", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateProgressBar() {
        let progress = Float(questionCounter) / Float(questionBankList.count)
        progressBar.setProgress(progress, animated: true)
    }
    
    func saveAvgToFile(score : Int, numAttempts: Int) -> Double{
        scoreObj.attempts = numAttempts
        let avg: Double = (Double(scoreObj.totalScore) + Double(score))/Double(numAttempts)
        scoreObj.totalScore = scoreObj.totalScore + score
        scoreObj.average = avg
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(scoreObj)
            try data.write(to: self.filePath2!)
        } catch{
            print (error)
        }
        return avg
        
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
