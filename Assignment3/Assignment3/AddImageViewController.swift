//
//  AddImageViewController.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-03-30.
//

import UIKit

class AddImageViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    public var delegate: AddingImageDelegateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
              let url = urlTextField.text, !url.isEmpty else {
            // display an error if either text field is empty
            let alert = UIAlertController(title: "Error", message: "Please enter a title and a URL.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        // add the new image title to the main view controller's image list
        let newImage = ImageInfo(title: title, url: url)
        delegate?.controllerDidFinishWithNewImage(image: newImage)
        if let navigationController = navigationController {
               navigationController.popViewController(animated: true)
           } else {
               dismiss(animated: true, completion: nil)
           }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.controllerDidCancel()
        if let navigationController = navigationController {
               navigationController.popViewController(animated: true)
           } else {
               dismiss(animated: true, completion: nil)
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
