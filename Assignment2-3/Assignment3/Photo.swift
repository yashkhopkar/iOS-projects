//
//  Photo.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-30.
//

import Foundation

class Photo: Codable {
    var id: Int?
    var img_src: URL?
    var earth_date: String?
    var rover: Rover?
    
    init(_id:Int, _img_src:URL, _earth_date:String, _rover:Rover){
        id = _id
        img_src = _img_src
        earth_date = _earth_date
        rover = _rover
    }
}

class PhotoList: Codable {
    var photos : [Photo] = []
}

class Rover: Codable {
    var name: String?
    
    init(_name: String) {
        name = _name
    }
}

class FavPhoto : Codable {
    var id: Int?
    var img_src: URL?
    var earth_date: String?
    var rover: String?
    
    init(_id:Int, _img_src:URL, _earth_date:String, _rover:String){
        id = _id
        img_src = _img_src
        earth_date = _earth_date
        rover = _rover
    }
}
