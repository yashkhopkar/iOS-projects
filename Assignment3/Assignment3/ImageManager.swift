//
//  ImageManager.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-03-31.
//

import Foundation

class ImageManager {
    
    private var listOfImages = [ImageInfo]()
    
    func addNewImage(image:ImageInfo){
        listOfImages.append(image)
    }
    
    func getAllImages() -> [ImageInfo]{
        return listOfImages
    }
    
}
