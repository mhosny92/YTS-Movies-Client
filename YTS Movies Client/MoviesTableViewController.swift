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
    
   
    @IBOutlet weak var searchMovieTextField: UITextField!{
        didSet{
            searchMovieTextField.delegate = self
        }
    }
    
    var searchText: String?{
        didSet{
            searchMovieTextField?.text = searchText
            searchMovieTextField?.resignFirstResponder()
            movies.removeAll()
            tableView.reloadData()
            searchMovies()
            title = searchText
            
            
        }
    }
    
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchMovieTextField {
            searchText = searchMovieTextField.text
        }
        return true
    }

    var page = 1
    var searchActive = false
    var movies = [Array<Movie>]()
    
    func insertMovies(_ newMovies: [Movie]){
        self.movies.append(newMovies)
        self.tableView.insertSections([0], with: .fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movies[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath)
        
        let movie: Movie = movies[indexPath.section][indexPath.row]
        
        if let movieCell = cell as? MovieViewCell {
            movieCell.movie = movie
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
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
