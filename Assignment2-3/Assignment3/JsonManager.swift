//
//  JsonManager.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-30.
//

import Foundation

class JsonManager{
    
    static var shared = JsonManager()
    func fromJsonDataToPhotosArray(jsonData : Data)->[Photo]{
        var photosArray = [Photo]()
        let decoder = JSONDecoder()
        do {
            let photoList = try decoder.decode(PhotoList.self, from: jsonData)
            for photo in photoList.photos {
                if photo.id == nil {
                    photo.id = 0
                }
                if photo.img_src == nil {
                    photo.img_src = URL(string: "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg")
                }
                if photo.earth_date == nil {
                    photo.earth_date = ""
                }
                if(photo.rover == nil){
                    let rover = Rover(_name: "N/A")
                    photo.rover = rover
                }
                photosArray.append(Photo(_id: photo.id!, _img_src: photo.img_src!, _earth_date: photo.earth_date!, _rover: photo.rover!))
            }
        }
        catch{
            print(error)
        }
        return photosArray
    }
}
