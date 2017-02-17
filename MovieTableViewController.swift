//
//  MovieTableViewController.swift
//  MovieDatabase
//
//  Created by Jeremiah Hawks on 2/17/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, MovieTableViewCellDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarController: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var movies: [Movie]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else { return 0 }
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)) as? MovieTableViewCell else { return UITableViewCell() }
        if let movies = movies {
            let movie = movies[indexPath.row]
            cell.movie = movie
            cell.delegate = self
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        MovieController.shared.fetchMovies(bySearchTerm: searchTerm) { (movies) in
            self.movies = movies
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                searchBar.text = ""
            }
        }
    }
}
