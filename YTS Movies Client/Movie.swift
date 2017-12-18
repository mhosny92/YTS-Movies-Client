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
    let descriptionFull:String
    let rating:Float
    let titleEnglish:String
    let year:Int
    let summary:String
    let genres: Set<String>
    let mediumCoverImage: URL
    let smallCoverImage: URL
    let largetCoverImage: URL
    
    init?(json: [String: Any]){
        guard let id = json["id"] as? Int,
            let descriptionFull = json["description_full"] as? String,
            let rating = json["rating"] as? Float,
            let titleEnglish = json["title_english"] as? String,
            let year = json["year"] as? Int,
            let summary = json["summary"] as? String,
            let genresJson = json["genres"] as? [String],
            let mediumCoverImage = json["medium_cover_image"] as? String,
            let smallCoverImage = json["small_cover_image"] as? String,
            let largeCoverImage = json["large_cover_image"] as? String
        else {
                return nil
        }
        var genres: Set<String> = []
        
        for str in genresJson{
            genres.insert(str)
        }
        self.descriptionFull = descriptionFull
        self.rating = rating
        self.titleEnglish = titleEnglish
        self.year = year
        self.summary = summary
        self.id = id
        self.genres = genres
        self.mediumCoverImage = URL.init(string: mediumCoverImage)!
        self.smallCoverImage = URL.init(string: smallCoverImage)!
        self.largetCoverImage = URL.init(string: largeCoverImage)!
    }
}
