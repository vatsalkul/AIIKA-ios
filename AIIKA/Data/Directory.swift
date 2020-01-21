//
//  Directory.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 04/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation

struct Directory: Decodable {
    
    let id: Int
    let name: String
    let father: String
    let email: String
    let occupation: String
    let city: String
    let state: String
    let country: String
    let mobile: String
    let imageUrl: String
    var imageData: Data?
}

class fetchDirectory{

 func fetchJson(completion: @escaping (Result<[Directory]?, Error>) -> ()){
    let jsonUrl = "https://aiika.herokuapp.com/directory"
    guard let url = URL(string: jsonUrl) else { return }
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
        
        if let err = err {
            completion(.failure(err))
            
        }
        //success
        do{
            let directory = try JSONDecoder().decode([Directory].self, from: data!)
            completion(.success(directory))
            

                      
        }catch let jsonError{
            
            completion(.failure(jsonError))
            
        }
        
        
    }.resume()
}

}

