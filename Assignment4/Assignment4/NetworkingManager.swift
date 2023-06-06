//
//  NetworkingManager.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-04-18.
//

import Foundation

class NetworkingManager {
    
    public static var shared = NetworkingManager()
    func getAPIData(url : String, completionHandler: @escaping (Result<Data,Error>)->Void){
        
        if let urlObject = URL(string: url){
            let task = URLSession.shared.dataTask(with: urlObject) { data, response, error in
                if error != nil {
                    // notify the listener
                    completionHandler(.failure(error!))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(error!))
                    return
                }
                
                completionHandler(.success(data!))
            }
            task.resume()
        }
    }
}
