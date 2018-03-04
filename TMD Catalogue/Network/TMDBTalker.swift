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
    
    func requestMovieList(_ listTitle: String, resultPage: Int = 1, successHandler: @escaping (_ successObject: BaseListResponse?) -> ()){
        
        Alamofire.request("\(baseURL+popular)", parameters: ["api_key": apiKey]).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    
                    let responseList = try JSONDecoder().decode(BaseListResponse.self, from: data!)
                    
                    successHandler(responseList)
                    
                } catch let error{
                    print ("Error while parsing response")
                    print(error)
                    successHandler(nil)

                }
            case .failure(_):
                print ("Failed to get movie list from url")
                successHandler(nil)

            }
            
        }
    
    }
    
    
}
