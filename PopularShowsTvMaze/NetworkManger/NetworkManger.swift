//
//  NetworkManger.swift
//  News
//
//  Created by Abdallah on 8/4/21.
//

import UIKit

class NetworkManger {
    
    static let shared = NetworkManger()
    
    let cache             = NSCache<NSString, UIImage>()

  // fetch Popuar Shows Movie
    func getPopularShows(completion: @escaping (Result<[PopularShow] , ResoneError>) -> Void){
        fetchGenericJSONData(urlString:URLS.PopularShows , completion: completion)
    }

    
    
    
    
    func fetchGenericJSONData<T:Codable>(urlString:String,completion: @escaping (Result<T , ResoneError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invaldURL))
            return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response  = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(.success(objects))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    
    
    // downLoadImage and save in cache

    func downLoadImage(from urlString:String, completed: @escaping (UIImage?)-> Void){
        let ketString = NSString(string: urlString)
        
        if let image = cache.object(forKey: ketString) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else{
            completed(nil)
            return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self ,
                error == nil ,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)else{
                    completed(nil)
                    return
                    
            }
            
            self.cache.setObject(image, forKey: ketString)
            completed(image)
        }
        task.resume()
    }
    
}
