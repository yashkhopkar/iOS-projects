//
//  FirebaseManager.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-07-30.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

class FirebaseManager {
    
    static var shared = FirebaseManager()
    let db = Firestore.firestore()
    
    func addPhotoToFavorites(photo: FavPhoto, completion: @escaping (Error?) -> Void) {
        var photoDict = [String: Any]()
        photoDict["id"] = photo.id
        photoDict["img_src"] = photo.img_src?.absoluteString
        photoDict["earth_date"] = photo.earth_date
        photoDict["rover"] = photo.rover
        
        db.collection("FavPhotos").addDocument(data: photoDict) { error in
            completion(error)
        }
    }
    
    func getAllFavoritePhotos(completion: @escaping (Result<[FavPhoto], Error>) -> Void) {
        db.collection("FavPhotos").getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                var photos = [FavPhoto]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["id"] as? Int
                    let img_src = URL(string: data["img_src"] as? String ?? "")
                    let earth_date = data["earth_date"] as? String
                    let rover = data["rover"] as? String
                    
                    if let id = id, let img_src = img_src, let earth_date = earth_date, let rover = rover {
                        photos.append(FavPhoto(_id: id, _img_src: img_src, _earth_date: earth_date, _rover: rover))
                    }
                }
                completion(.success(photos))
            }
        }
    }
}

