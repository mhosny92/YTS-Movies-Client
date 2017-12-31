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

    var viewModel: MovieViewModel?
    
    @IBOutlet weak var mediumCoverImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDescription: UITextView!
    @IBOutlet weak var rating: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mDescription.isEditable = false
        title = viewModel?.titleEnglish
        updateUI()
        rating.settings.updateOnTouch = false
    }
    /*
     updates the UI based on the movie change.
     */
    private func updateUI(){
        mTitle.text = viewModel?.titleEnglish
        mDescription.text = viewModel!.descriptionFull
        mediumCoverImage.kf.setImage(with: viewModel?.mediumCoverImage)
        rating.rating = Double(viewModel!.rating)
    }

}
