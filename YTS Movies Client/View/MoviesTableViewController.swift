//
//  MoviesTableViewController.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Moya
import Kingfisher

class MoviesTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    // ViewModel outlet
    @IBOutlet weak var viewModel: SearchMoviesViewModel!
    
    /*
     Search Movie TextField
     */
    @IBOutlet weak var searchMovieTextField: UITextField!{
        didSet{
            searchMovieTextField.delegate = self
        }
    }
    
    /*
     Stored property for the search text field
     When it's set we remove the old search result and update our tableview
     and start making an api request for searching the movie name
     */
    var searchText: String?{
        didSet{
            searchMovieTextField?.text = searchText
            searchMovieTextField?.resignFirstResponder()
            viewModel.removeAllMovies()
            viewModel.searchMoviesBy(movieName: searchText!){
                self.tableView.reloadData()
            }
        }
    }
    /*
     Called when the user hits the return button in keyboard entering the search term.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchMovieTextField {
            searchText = searchMovieTextField.text
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        title = "Search YTS Movies"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath)
        if let movieCell = cell as? MovieViewCell {
            configureMovieCell(cell: movieCell, forRowAtIndexPath: indexPath)
        }
        return cell
    }
    /*
     Configure table cell (now cell cannot see the movie without going through the ViewModel
     */
    fileprivate func configureMovieCell(cell: MovieViewCell, forRowAtIndexPath indexPath: IndexPath){
        cell.rating.settings.updateOnTouch = false
        cell.title.text = viewModel.movieTitle(at: indexPath)
        cell.rating.rating = viewModel.movieRating(at: indexPath)
        cell.summary.text = viewModel.movieSummary(at: indexPath)
        cell.smallCoverImage.kf.setImage(with: viewModel.movieSmallImageResource(at: indexPath))
    }
    
    /*
     Preparing for segue transition when the user hits a certain cell.
     Sets the movie for the Movie View Controller.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails"{
            let controller = segue.destination as! MovieViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                let movieViewModel = MovieViewModel(withMovie: viewModel.movieAtIndexPath(indexPath)!)
                controller.viewModel = movieViewModel
            }
        }
    }
    

}
