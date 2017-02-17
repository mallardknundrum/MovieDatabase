//
//  Movie.swift
//  MovieDatabase
//
//  Created by Jeremiah Hawks on 2/17/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import UIKit
class Movie {
    
    private let titleKey = "original_title"
    private let descriptionKey = "overview"
    private let ratingKey = "vote_average"
    private let imageEndpointKey = "poster_path"
    
    let title: String
    let description: String
    let rating: Float
    let imageEndpoint: String
    let imageStartpointURL = "http://image.tmdb.org/t/p/w500/"
    var imageURL: String {
        return imageStartpointURL + imageEndpoint
    }
    var image: UIImage?
    
    init?(jsonDictoinary: [String: Any]) {
        guard let title = jsonDictoinary[titleKey] as? String,
              let description = jsonDictoinary[descriptionKey] as? String,
              let rating = jsonDictoinary[ratingKey] as? Float,
              let imageEndpoint = jsonDictoinary[imageEndpointKey] as? String else { return nil }
        self.description = description
        self.title = title
        self.rating = rating
        self.imageEndpoint = imageEndpoint
        ImageController.image(forURL: self.imageURL) { (image) in
            self.image = image
        }
    }
}
