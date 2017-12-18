//
//  MovieViewCell.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var smallCoverImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    var movie: Movie? { didSet{ updateUI() } }
    /*
     updates the UI based on the movie change.
     */
    private func updateUI(){
        title.text = movie?.titleEnglish
        summary.text = movie?.summary
        let resource = ImageResource(downloadURL: movie!.mediumCoverImage, cacheKey: movie?.titleEnglish)
        smallCoverImage.kf.setImage(with: resource)
        rating.rating = Double(movie!.rating)
    }

}
