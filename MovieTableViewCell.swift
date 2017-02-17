//
//  MovieTableViewCell.swift
//  MovieDatabase
//
//  Created by Jeremiah Hawks on 2/17/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    weak var delegate: MovieTableViewCellDelegate?
    
    var movie: Movie? {
        didSet {
                self.updateCell()
        }
    }
    
    func updateCell() {
        
        guard let movie = movie else { return }
        self.movieTitleLabel.text = movie.title
        self.movieDescriptionTextView.text = movie.description
        self.movieRatingLabel.text = "\(movie.rating)/10"
        ImageController.image(forURL: movie.imageURL, completion: { (image) in
            self.movieImageView.image = image
            
        })
    }
    
}

protocol MovieTableViewCellDelegate: class {
    
}

