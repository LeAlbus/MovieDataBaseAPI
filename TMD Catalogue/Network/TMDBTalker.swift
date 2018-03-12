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
    
    func requestMovieList(genreID: Int = -1, resultPage: Int = 1, successHandler: @escaping (_ successObject: BaseListResponse?) -> ()){
        
        isGettingData = true
        
        var urlToRequest = "\(baseMovieURL+popular)"
        
        if genreID != -1{
            urlToRequest = "\(baseURL+genre+String(genreID)+movies)"
        }

        Alamofire.request(urlToRequest, parameters: ["api_key": apiKey, "page": resultPage]).responseJSON { response in 
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
    
    func requestGenreList(successHandler: @escaping (_ successObject: [Genre]?) -> ()){

        Alamofire.request("\(baseURL+genreList)", parameters: ["api_key": apiKey]).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    
                    let genreList = try JSONDecoder().decode(GenreList.self, from: data!)
                    
                    successHandler(genreList.genres)
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
    
    func requestMovieCasts(movieID: Int, successHandler: @escaping (_ successObject: [CastBaseData]?) -> ()){
        
        Alamofire.request("\(baseMovieURL+String(movieID)+casts)", parameters: ["api_key": apiKey]).responseJSON { response in
            print (response)
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    
                    let responseList = try JSONDecoder().decode(CastList.self, from: data!)
                    
                    successHandler(responseList.cast)
                    self.isGettingData = false
                    
                }catch let error{
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
}
