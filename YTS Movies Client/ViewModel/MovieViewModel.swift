//
//  MovieViewModelImplementation.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/31/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import Kingfisher

class MovieViewModel: NSObject, MovieViewModelProtocol{
    
    
    var id: Int
    var titleEnglish: String
    var rating: Double
    var year: String
    var summary: String
    var smallCoverImage: ImageResource
    var mediumCoverImage: ImageResource
    var largeCoverImage: ImageResource
    var descriptionFull: String
    
    init(withMovie movie: Movie){
        self.id = movie.id
        self.titleEnglish = movie.titleEnglish
        self.rating = movie.rating
        self.year = String(movie.year)
        self.summary = movie.summary
        self.descriptionFull = movie.descriptionFull
        self.smallCoverImage = ImageResource(downloadURL: movie.smallCoverImage, cacheKey: self.titleEnglish)
        self.mediumCoverImage = ImageResource(downloadURL: movie.mediumCoverImage, cacheKey: self.titleEnglish)
        self.largeCoverImage = ImageResource(downloadURL: movie.smallCoverImage, cacheKey: self.titleEnglish)
    }
    
}
