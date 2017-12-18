//
//  MovieViewController.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    var movie : Movie?
    
    @IBOutlet weak var mediumCoverImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mDescription.isEditable = false
        title = movie?.titleEnglish
        updateUI()
    }
    
    private func updateUI(){
        mTitle.text = movie?.titleEnglish
        mDescription.text = movie?.descriptionFull
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
