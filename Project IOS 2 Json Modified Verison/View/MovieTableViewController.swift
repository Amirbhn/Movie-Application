//
//  MovieTableViewController.swift
//  Project IOS 2 Json Modified Verison
//
//  Created by Map04 on 2021-04-14.

import UIKit

class MovieTableViewController: UITableViewController {
    var MovieArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let annnonymousfunc = { (fetchedMovieArray : [Movie]) in
            DispatchQueue.main.async {
                self.MovieArray =  fetchedMovieArray
                self.tableView.reloadData()
            }
        }
        
        MovieApi.shared.fetchRootObject(onCompletion: annnonymousfunc)
        print(MovieArray)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovielTableViewCell
        let movie  = MovieArray[indexPath.row]
        cell.setCellWithValuesOf(movie: movie)
        return cell
    }
    // MARK: - Bring Data Back And forth
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "From Cell"{
            let indexPath = tableView.indexPathForSelectedRow!
            let movie = MovieArray[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let showMovieDetailController = navController.topViewController as! MovieDetailTableViewController
            showMovieDetailController.movie = movie
        }
    }
    
    @IBAction func unwindToMovieTableView(_ unwindSegue: UIStoryboardSegue) {
    }
    // MARK: - Handle Edit and Moving elements
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MovieArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedMovie = MovieArray.remove(at: fromIndexPath.row)
        MovieArray.insert(movedMovie, at: to.row)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
