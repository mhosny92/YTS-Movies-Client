//
//  MovieViewModelProtocol.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/31/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import Kingfisher


protocol MovieViewModelProtocol{
    
    var id: Int {get}
    var titleEnglish: String {get}
    var year: String {get}
    var rating: Double {get}
    var summary: String {get}
    var smallCoverImage: ImageResource {get}
    var mediumCoverImage: ImageResource {get}
    var largeCoverImage: ImageResource {get}
    var descriptionFull: String {get}
    
    
}
