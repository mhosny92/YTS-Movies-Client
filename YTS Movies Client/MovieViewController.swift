//
//  MovieViewController.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class MovieViewController: UIViewController {

    var movie : Movie?
    
    @IBOutlet weak var mediumCoverImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDescription: UITextView!
    @IBOutlet weak var rating: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mDescription.isEditable = false
        title = movie?.titleEnglish
        updateUI()
        rating.settings.updateOnTouch = false
    }
    /*
     updates the UI based on the movie change.
     */
    private func updateUI(){
        mTitle.text = movie?.titleEnglish
        mDescription.text = movie?.descriptionFull
        let resource = ImageResource(downloadURL: movie!.largetCoverImage, cacheKey: movie!.titleEnglish)
        mediumCoverImage.kf.setImage(with: resource)
        rating.rating = Double(movie!.rating)
    }

}
