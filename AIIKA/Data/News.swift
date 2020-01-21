//
//  News.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 04/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation
struct CatNews: Decodable {
    let News: [News]
}

struct News: Decodable {
    let id: Int
    let title: String
    let image: String
    let description: String
    let fb: String
    let yt: String
}
class fetchNews {
    

 func fetchJson(completion: @escaping (Result<CatNews?, Error>) -> ()){
    let jsonUrl = "http://aiika.herokuapp.com/news"
    guard let url = URL(string: jsonUrl) else { return }
    URLSession.shared.dataTask(with: url) { (data, resp, err) in

        if let err = err {
            completion(.failure(err))

        }
        //success
        do{
            let news = try JSONDecoder().decode(CatNews.self, from: data!)
            completion(.success(news))



        }catch let jsonError{

            completion(.failure(jsonError))

        }


    }.resume()
}


}
