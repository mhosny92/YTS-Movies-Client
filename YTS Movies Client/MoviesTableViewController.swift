//
//  MoviesTableViewController.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Moya

class MoviesTableViewController: UITableViewController, UITextFieldDelegate {
    
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
            movies.removeAll()
            tableView.reloadData()
            searchMovies()
        }
    }
    /*
     Searchs a movie in yts api and saves the resulting movies in a section in movies array
     */
    func searchMovies(){
        var moviesSection = [Movie]()
        let provider = MoyaProvider<YTSAllMoviesService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.searchMoviesBy(name: self.searchText! ,page: self.page)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
                if let json = jsonObj as? [String: Any]{
                    if let jsonData = json["data"] as? [String: Any]{
                        if let moviesData = jsonData["movies"] as? [[String: Any]]{
                            for movieData in moviesData{
                                let movie = Movie(json: movieData)!
                                moviesSection.append(movie)
                            }
                        }
                    }
                }
                self.insertMovies(moviesSection)
            case let .failure(error):
                // handle errors here
                print(error)
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

    var page = 1
    var searchActive = false
    var movies = [Array<Movie>]()
    
    /*
     Insert the search results in the movies array
     */
    func insertMovies(_ newMovies: [Movie]){
        self.movies.append(newMovies)
        self.tableView.insertSections([0], with: .fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        title = "Search YTS Movies"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath)
        
        let movie: Movie = movies[indexPath.section][indexPath.row]
        
        if let movieCell = cell as? MovieViewCell {
            movieCell.movie = movie
            movieCell.rating.settings.updateOnTouch = false
        }
        
        return cell
    }
    /*
     Preparing for segue transition when the user hits a certain cell.
     Sets the movie for the Movie View Controller.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails"{
            let controller = segue.destination as! MovieViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.movie = movies[indexPath.section][indexPath.row]
            }
        }
    }
    

}
