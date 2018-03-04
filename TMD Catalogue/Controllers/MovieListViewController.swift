//
//  MovieListViewController.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 03/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class MovieListViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("\(baseURL+popular)", parameters: ["api_key": apiKey]).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                  
                    let responseList = try JSONDecoder().decode(BaseListResponse.self, from: data!)
                    
                } catch let error{
                    print ("Error while parsing response")
                    print(error)
                }
            case .failure(_):
                print ("Failed to get movie list from url")
            }
            
        }
        
    }
    
}
