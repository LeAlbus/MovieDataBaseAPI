//
//  TMDBTalker.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 04/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import Alamofire

class TMDBTalker{
    
    static let sharedInstance = TMDBTalker()
    var isGettingData = false
    
    func requestMovieList(_ listTitle: String, resultPage: Int = 1, successHandler: @escaping (_ successObject: BaseListResponse?) -> ()){
        
        isGettingData = true

        Alamofire.request("\(baseURL+popular)", parameters: ["api_key": apiKey, "page": resultPage]).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    
                    let responseList = try JSONDecoder().decode(BaseListResponse.self, from: data!)
                    
                    successHandler(responseList)
                    self.isGettingData = false
                    
                } catch let error{
                    print ("Error while parsing response")
                    print(error)
                    successHandler(nil)
                    self.isGettingData = false

                }
            case .failure(_):
                print ("Failed to get movie list from url")
                successHandler(nil)
                self.isGettingData = false

            }
            
        }
    
    }
    
//    func requestGenreList(successHandler: @escaping (_ successObject: BaseListResponse?) -> ()){
//
//
//    }
    
    
}
