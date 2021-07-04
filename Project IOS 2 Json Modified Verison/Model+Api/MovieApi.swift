//
//  MovieApi.swift
//  Project IOS 2 Json Modified Verison
//
//  Created by Map04 on 2021-04-13.
//

import Foundation

class MovieApi {

    static let shared = MovieApi()
    
    func fetchRootObject ( onCompletion :@escaping ([Movie]) ->() ){
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4459228331a35fd48c10590c1741dcc5&language=en-US&page=1"
        let url  = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data , response , error) in
            guard let data  = data  else {
                print(" data was nil")
                return
            }
            
            guard let arrayOfmovies = try? JSONDecoder().decode(MoviesData.self, from: data) else {
          print("couldnt decode Json")
            return}
            
            onCompletion(arrayOfmovies.movies)
        }
        
        task.resume()
    }
}

struct MoviesData: Decodable {
    let movies: [Movie]
    
     enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let year: String?
    let title: String
    let rate: Double
    let posterImage: String
    let overview: String
    let originalLanguage : String
    
     enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case originalLanguage = "original_language"
    }
    
}
