//
//  ViewController.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-03-30.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddingImageDelegateProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var manager: ImageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        imageView.image = UIImage(named: "emptyImage");
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let aVC = segue.destination as! AddImageViewController
        aVC.delegate = self
    }
    
    func controllerDidFinishWithNewImage(image: ImageInfo) {
        manager.addNewImage(image: image)
        pickerView.reloadAllComponents()
    }
    
    func controllerDidCancel() {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return manager.getAllImages().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return manager.getAllImages()[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedImageURL = manager.getAllImages()[row].url
        
        if let url = URL(string: selectedImageURL) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}

