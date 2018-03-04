//
//  MovieListController.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 04/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class MovieListController: UITableViewController{
    
    var currentMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension

        TMDBTalker().requestMovieList(popular) { response in
            
            if let movieList = response?.results{
                
                self.currentMovies = movieList
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieCell = self.tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        
        if !currentMovies.isEmpty{
            
            let movieForCell = currentMovies[indexPath.row]
            
            let description = movieForCell.overview
            let year = movieForCell.releaseDate.prefix(4)
            let rating = movieForCell.rating
            
            cell.movieDescriptionLabel.text = String(description)
            cell.yearLabel.text = String(year)
            cell.ratingLabel.text = String(rating)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentMovies.count
    }
    
}

