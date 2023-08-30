//
//  AddToDoViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-06-23.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    
    @IBOutlet weak var txtTask: UITextField!
    
    @IBOutlet weak var isUrgent: UISwitch!
    
    @IBOutlet weak var isComplete: UISwitch!
    
    var currentToDo: ToDo?
    
    var dbManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let existingToDo = currentToDo {
                   txtTask.text = existingToDo.task
                   isUrgent.isOn = existingToDo.urgent
                   isComplete.isOn = existingToDo.complete
               }
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        guard let task = txtTask.text, !task.isEmpty else {
                   return
               }
               
               if let existingToDo = currentToDo {
                   dbManager.updateToDo(existingToDo, task: task, complete: isComplete.isOn, urgent: isUrgent.isOn)
               } else {
                   dbManager.createToDo(task: task,complete: isComplete.isOn, urgent: isUrgent.isOn)
               }
               
               navigationController?.popViewController(animated: true)
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
