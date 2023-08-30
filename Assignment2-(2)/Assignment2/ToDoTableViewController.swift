//
//  ToDoTableViewController.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-06-23.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<ToDo>!
    var dbManager = CoreDataManager.shared
    var selectedToDo : ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = dbManager.toDoFRC
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch ToDo items: \(error)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            fatalError("Failed to fetch ToDo items: \(error)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let toDo = fetchedResultsController.object(at: indexPath)
        
        // Configure the cell with the ToDo item properties
        cell.textLabel?.text = toDo.task
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .short
           dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: toDo.date!)
           cell.detailTextLabel?.text = dateString
        
        if toDo.complete {
                cell.textLabel?.textColor = UIColor.green
            } else {
                cell.textLabel?.textColor = UIColor.red
            }
        
        if toDo.urgent {
            let hourglassImage = UIImage(systemName: "hourglass")
            cell.imageView?.image = hourglassImage
            } else {
                cell.imageView?.image = nil
            }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedToDo = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "toAddToDo", sender: self)
    }
    
    // MARK: - Table view delegate
    
    // Implement any additional UITableViewDelegate methods if needed
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    // Implement the necessary NSFetchedResultsControllerDelegate methods if needed
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddToDo", let destination = segue.destination as? AddToDoViewController, let _ = selectedToDo {
            destination.currentToDo = selectedToDo
        }
    }
}
