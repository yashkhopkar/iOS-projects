//
//  ViewController.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-21.
//

import UIKit

class AddPhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var roverPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imagePicker: UIPickerView!
    
    @IBOutlet weak var numOfPhotos: UILabel!
    
    let rovers = ["Opportunity", "Curiosity", "Spirit"]
    var allPhotosFromAPI = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roverPicker.delegate = self
        roverPicker.dataSource = self
        imagePicker.delegate = self
        imagePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == roverPicker {
            return rovers.count
        } else {
            return allPhotosFromAPI.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == roverPicker {
            return rovers[row]
        } else {
            return "Image \(row+1)"
        }
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let selectedRover = rovers[roverPicker.selectedRow(inComponent: 0)]
        fetchImagesForRover(selectedRover)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == roverPicker {
            fetchImagesForRover(rovers[row])
        } else if !allPhotosFromAPI.isEmpty {
            let url = allPhotosFromAPI[row].img_src
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url!), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }
        }
    }
    
    private func fetchImagesForRover(_ rover: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(selectedDate)&api_key=hKb3MfbJdNUfC34UXXVHieJdW4fzYk8NdXYJldSv"
        
        NetworkingManager.shared.getAPIData(url: urlString) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.allPhotosFromAPI = [Photo]()
                    
                case .success(let data):
                    self.allPhotosFromAPI =   JsonManager.shared.fromJsonDataToPhotosArray(jsonData: data)
                }
                
                self.numOfPhotos.text = "\(self.allPhotosFromAPI.count)"
                self.imagePicker.reloadAllComponents()
                
                if !self.allPhotosFromAPI.isEmpty {
                    self.imagePicker.selectRow(0, inComponent: 0, animated: true)
                    self.pickerView(self.imagePicker, didSelectRow: 0, inComponent: 0)
                } else {
                    self.image.image = nil
                }
            }
        }
    }
    
    
    @IBAction func addToFav(_ sender: UIBarButtonItem) {
        let selectedPhotoIndex = imagePicker.selectedRow(inComponent: 0)
        if selectedPhotoIndex < allPhotosFromAPI.count {
            let selectedPhoto = allPhotosFromAPI[selectedPhotoIndex]
            let favPhoto = FavPhoto(_id: selectedPhoto.id!, _img_src: selectedPhoto.img_src!, _earth_date: selectedPhoto.earth_date!, _rover: (selectedPhoto.rover?.name!)!)
            FirebaseManager.shared.addPhotoToFavorites(photo: favPhoto) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert(with: "Error", message: "Failed to save photo to favorites: \(error)")
                    } else {
                        self.showAlert(with: "Success", message: "Successfully saved photo to favorites")
                    }
                }
            }
        }
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

