//
//  Decodables.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 04/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    
    let imagePath: String
    let title: String
    let rating: Double
    let releaseDate: String
    let overview: String
    
    private enum CodingKeys: String, CodingKey{
        case imagePath = "poster_path"
        case title = "title"
        case rating = "vote_average"
        case releaseDate = "release_date"
        case overview = "overview"
    }
}

struct GenreList: Decodable{
    
    let genres: [Genre]

    private enum CodingKeys: String, CodingKey{
        case genres = "genres"
    }
}

struct Genre: Decodable{
    
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
    }
}

struct BaseListResponse: Decodable{
    
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey{
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
