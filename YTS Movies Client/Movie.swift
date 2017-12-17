//
//  Movie.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation

struct Movie{
    
    let id:Int
    let backgroundImageURL:URL
    let backGroundImageOriginalURL:URL
    let dateUploaded:String
    let descriptionFull:String
    let language:String
    let rating:Float
    let titleEnglish:String
    let year:Int
    let summary:String
    let genres: Set<String>
    let mediumCoverImage: URL
    
    init?(json: [String: Any]){
        guard let id = json["id"] as? Int,
            let backgroundImage = json["background_image"] as? String,
            let backGroundImageOriginal = json["background_image_original"] as? String,
            let dateUploaded = json["date_uploaded"] as? String,
            let descriptionFull = json["description_full"] as? String,
            let language = json["language"] as? String,
            let rating = json["rating"] as? Float,
            let titleEnglish = json["title_english"] as? String,
            let year = json["year"] as? Int,
            let summary = json["summary"] as? String,
            let genresJson = json["genres"] as? [String],
            let mediumCoverImage = json["medium_cover_image"] as? String
        else {
                return nil
        }
        var genres: Set<String> = []
        
        for str in genresJson{
            genres.insert(str)
        }
        self.dateUploaded = dateUploaded
        self.descriptionFull = descriptionFull
        self.language = language
        self.rating = rating
        self.titleEnglish = titleEnglish
        self.year = year
        self.summary = summary
        self.id = id
        self.backgroundImageURL = URL.init(string: backgroundImage)!
        self.backGroundImageOriginalURL = URL.init(string: backGroundImageOriginal)!
        self.genres = genres
        self.mediumCoverImage = URL.init(string: mediumCoverImage)!
    }
}
