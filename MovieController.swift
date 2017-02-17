//
//  MovieController.swift
//  MovieDatabase
//
//  Created by Jeremiah Hawks on 2/17/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import Foundation

class MovieController {
    
    static let shared = MovieController()
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    let apiKey = "e1d1200cb6c2133d1a0a490d72bbd5e4"
    
    func fetchMovies(bySearchTerm searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        guard let url = baseURL else { completion([]); return }
        let searchTermSpacesReplaced = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let parameters = ["api_key": apiKey, "language": "en-US", "query": searchTermSpacesReplaced]
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: parameters, body: nil) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { completion([]); return }
            guard let topDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { print("Serialization failed. \n dataResponseString: \n \(responseDataString)"); completion([]); return }
            guard let resultsDictionary = topDictionary["results"] as? [[String: Any]] else { print("Could not get results dictionary from top dictionary."); completion([]); return }
            let movies = resultsDictionary.flatMap({Movie(jsonDictoinary: $0)})
            for movie in movies {
                ImageController.image(forURL: movie.imageURL, completion: { (image) in
                    movie.image = image
                })
            }
            
            completion(movies)
            return
        }
    }
}
