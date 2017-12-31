//
//  ViewModel.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/31/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Kingfisher

class SearchMoviesViewModel: NSObject {
    
    @IBOutlet var moviesClient: MoviesClient!
    var movies: [Array<Movie>]?
    
    func searchMoviesBy(movieName: String, completion: @escaping ()->()){
        moviesClient.searchMoviesBy(movieName: movieName){ movies in
            self.movies = movies
            completion()
        }
    }
    
    func numberOfSections() -> Int{
        return movies?.count ?? 0
    }
    
    func removeAllMovies(){
        movies?.removeAll()
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        return movies?[section].count ?? 0
    }
    
    func movieTitle(at indexPath: IndexPath) -> String{
        return movies![indexPath.section][indexPath.row].titleEnglish
    }
    
    func movieRating(at indexPath: IndexPath) -> Double{
        return movies![indexPath.section][indexPath.row].rating
    }
    
    func movieSummary(at indexPath: IndexPath) -> String {
        return movies![indexPath.section][indexPath.row].summary
    }
    
    func movieSmallImageResource(at indexPath: IndexPath) -> ImageResource{
        let resource = ImageResource(downloadURL: movies![indexPath.section][indexPath.row].smallCoverImage, cacheKey: movies![indexPath.section][indexPath.row].titleEnglish)
        return resource
    }
    
    func movieMeduimImageResource(at indexPath: IndexPath) -> ImageResource{
        let resource = ImageResource(downloadURL: movies![indexPath.section][indexPath.row].mediumCoverImage, cacheKey: movies![indexPath.section][indexPath.row].titleEnglish)
        return resource
    }
    
    func movieLargeImageResource(at indexPath: IndexPath) -> ImageResource{
        let resource = ImageResource(downloadURL: movies![indexPath.section][indexPath.row].largetCoverImage, cacheKey: movies![indexPath.section][indexPath.row].titleEnglish)
        return resource
    }
    func movieAtIndexPath(_ indexPath: IndexPath) -> Movie? {
        return movies?[indexPath.section][indexPath.row]
    }

}
