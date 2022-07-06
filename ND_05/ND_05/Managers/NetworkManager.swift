//
//  NetworkManager.swift
//  ND_05
//
//  Created by Paul Nguyen on 7/5/22.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    func getFeed(page: Int, completion: @escaping (Result<FeedInfo, NDError>) -> Void) {
        guard let url = URL(string: "https://andrewmunn.github.io/newsfeed/page\(page).json") else {
            completion(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            do {
                //let feed = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let feed = try JSONDecoder().decode(FeedInfo.self, from: data)
                completion(.success(feed))
                print(feed)
            } catch {
                completion(.failure(.unableToDecode))
                print("error")
            }
        }
        task.resume()
    }
}
