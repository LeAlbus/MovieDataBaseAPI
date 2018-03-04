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
            let description = currentMovies[indexPath.row].overview
            
            
            let index = description.index(description.startIndex, offsetBy: 105)
            let shortDescription = description.prefix(upTo: index)
          
            cell.movieDescriptionLabel.text = String(shortDescription)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentMovies.count
    }
    
}

