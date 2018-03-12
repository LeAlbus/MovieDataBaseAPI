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
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movieInfo: Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.castCollection.delegate = CastCollectionViewController.sharedInstance
        self.castCollection.dataSource = CastCollectionViewController.sharedInstance
        self.showMovieInfo()

        //self.scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+100)

      // self.contentView.sizeToFit()

        //self.scrollView.contentSize = CGSizemake
        //self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 12093)

    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func resizeScrollView(){
        var contentRect = CGRect.zero

        for view in self.contentView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        //self.contentView.frame = contentRect.size
        self.contentView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: contentRect.height)

       
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
        self.movieBanner.image = UIImage(named: "PlaceholderPoster")!
        TMDBTalker.sharedInstance.requestMovieImage(movieID: (movieInfo?.id)!){imagePath in

            let path: String = imagePath?.filePath as! String

            let movieBannerURL = "\(posterURL)\(path)"
            let placeholderImage = UIImage(named: "PlaceholderPoster")!

            self.movieBanner.af_setImage(withURL: URL(string: movieBannerURL)!, placeholderImage: placeholderImage)
            
        }
        
        TMDBTalker.sharedInstance.requestMovieCasts(movieID: (movieInfo?.id)!){ cast in
            if cast != nil{

                self.setCastData(cast!)

            } else{
                 print ("No cast found")
            }
        }
        
        self.loadImage()
        
        self.resizeScrollView()
    }
    
    func setCastData(_ cast: [CastBaseData]){
        
        CastCollectionViewController.sharedInstance.setCastData(cast)
        self.castCollection.reloadData()
    }
}
