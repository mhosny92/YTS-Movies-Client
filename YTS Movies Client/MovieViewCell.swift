//
//  MovieViewCell.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var smallCoverImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    var movie: Movie? { didSet{ updateUI() } }
    private func updateUI(){
        title.text = movie?.titleEnglish
        summary.text = movie?.summary
        let resource = ImageResource(downloadURL: movie!.mediumCoverImage, cacheKey: movie?.titleEnglish)
        smallCoverImage.kf.setImage(with: resource)
    }

}
