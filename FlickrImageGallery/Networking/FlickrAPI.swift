//
//  FlickrAPI.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Foundation

enum ResultType {
    case Success(r: [FlickrMedia])
    case Error(e: Error)
}

class FlickrAPI {
    
    // MARK: - Properties

    var urlComponents: URLComponents
    var currentSearchTag: String {
        return "nature" //todo remove hardcoded value
    }
    
    // MARK: - Object lifecycle

    init() {
        urlComponents = URLComponents(string: "https://api.flickr.com/")!
        urlComponents.queryItems = [
            URLQueryItem(name: "lang", value: "en-us"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "tags", value: currentSearchTag),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
    }
    
    // MARK: - Request
    
    func request(path: String, completion: @escaping(ResultType) -> Void ) {
        urlComponents.path = path
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            guard error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let item = try JSONSerialization.data(withJSONObject: json["items"]!, options: [])
                let decoder = JSONDecoder()
                let mediaArray = try decoder.decode([FlickrMedia].self, from: item)
                DispatchQueue.main.async {
                    completion(ResultType.Success(r: mediaArray))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(ResultType.Error(e: error))
                }
            }
        }
        task.resume()
    }
}
