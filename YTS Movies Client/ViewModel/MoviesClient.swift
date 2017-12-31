//
//  MoviesClient.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/31/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Moya

class MoviesClient: NSObject {
    
    
    var movies: [Array<Movie>]?
    
    func searchMoviesBy(movieName: String, completion: @escaping ([Array<Movie>]?)->()){
        var moviesSection = [Movie]()
        let provider = MoyaProvider<YTSAllMoviesService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.searchMoviesBy(name: movieName ,page: 1)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
                if let json = jsonObj as? [String: Any]{
                    if let jsonData = json["data"] as? [String: Any]{
                        if let moviesData = jsonData["movies"] as? [[String: Any]]{
                            for movieData in moviesData{
                                let movie = Movie(json: movieData)!
                                moviesSection.append(movie)
                            }
                        }
                    }
                }
                self.insertMovies(moviesSection)
                completion(self.movies)
            case let .failure(error):
                // handle errors here
                print(error)
            }
        }
    }
    /*
     Insert the search results in the movies array
     */
    fileprivate func insertMovies(_ newMovies: [Movie]){
        /*
         Initialize my optional array value
         */
        if self.movies == nil {
            self.movies = [Array<Movie>]()
        }
        self.movies?.append(newMovies)
    }

}
