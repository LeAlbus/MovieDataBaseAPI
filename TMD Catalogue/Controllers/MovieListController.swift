//
//  MovieListController.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 04/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import AlamofireImage
import UIKit

class MovieListController: UITableViewController{
    
    var currentMovies: [Movie] = []
    var loadedPages = 1
    var currentGenreID = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectNewListWithGenre(_:)), name:NSNotification.Name(rawValue: "genreSelected"), object: nil)

        
        self.getListValues(forGenre: -1) //-1 for no genre
    }
    
    func getListValues(forGenre: Int){
        
        self.currentGenreID = forGenre
        
        TMDBTalker.sharedInstance.requestMovieList(genreID: forGenre) { response in
            
            if let movieList = response?.results{
                
                self.currentMovies = movieList
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func selectNewListWithGenre(_ notification: NSNotification){
        
        if let id: Int = notification.userInfo!["id"] as? Int{
                self.getListValues(forGenre: id)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: MovieCell = self.tableView.cellForRow(at: indexPath) as! MovieCell

        let movieDetail = navigationController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailView") as? MovieDetailViewController
       
        movieDetail?.movieInfo = cell.movieInfo
        
    self.navigationController?.pushViewController(movieDetail!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieCell = self.tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        
        if !currentMovies.isEmpty{
            
            let movieForCell = currentMovies[indexPath.row]
            
            cell.movieInfo = movieForCell
            
            let description = movieForCell.overview
            let year = movieForCell.releaseDate.prefix(4)
            let rating = movieForCell.rating
            
            let posterPath = "\(posterURL)\(movieForCell.imagePath)"
            let placeholderImage = UIImage(named: "PlaceholderPoster")!

            cell.moviePoster.af_setImage(withURL: URL(string: posterPath)!, placeholderImage: placeholderImage)
            
            cell.movieDescriptionLabel.text = String(description)
            cell.yearLabel.text = String(year)
            cell.ratingLabel.text = String(rating)
            
            if indexPath.row % 2 == 0{
                
                cell.backgroundColor = UIColor(red: 32/255, green: 36/255, blue: 70/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor(red: 2/255, green: 29/255, blue: 38/255, alpha: 1)

            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentMovies.count
    }
 
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let scrollViewHeight = scrollView.frame.size.height;
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollOffset = scrollView.contentOffset.y;
        
        if ((scrollOffset + scrollViewHeight) - 20 >= scrollContentSizeHeight && !TMDBTalker.sharedInstance.isGettingData)
        {
            self.loadedPages += 1
            TMDBTalker.sharedInstance.requestMovieList(genreID: self.currentGenreID, resultPage: loadedPages) { response in
                
                if let movieList = response?.results{

                    self.currentMovies.append(contentsOf: movieList)
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
}

