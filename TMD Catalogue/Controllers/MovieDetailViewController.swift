//
//  MovieDetailViewController.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 03/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import AlamofireImage
import UIKit

class MovieDetailViewController: UIViewController{
   
    
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movieInfo: Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showMovieInfo()

    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    func loadImage(){
        let placeholderImage = UIImage(named: "PlaceholderPoster")!
        let posterPath: String = (self.movieInfo?.imagePath)!
        let posterFullURL = "\(posterURL)\(posterPath)"
  
         self.moviePoster.af_setImage(withURL: URL(string: posterFullURL)!, placeholderImage: placeholderImage)
    }
    
    func showMovieInfo(){
        self.movieTitle.text = movieInfo?.title
        self.movieScore.text = movieInfo?.rating.description
        self.movieReleaseDate.text = movieInfo?.releaseDate
        self.movieOverview.text = movieInfo?.overview
        
        TMDBTalker.sharedInstance.requestMovieCasts((movieInfo?.id)!)
        
        self.loadImage()
    }
}
