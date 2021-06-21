//
//  MovieDetailTableViewController.swift
//  Project IOS 2 Json Modified Verison
//
//  Created by Map04 on 2021-04-14.
//
import SafariServices
import UIKit

class MovieDetailTableViewController: UITableViewController {
    var movie : Movie?
    
    func updateSaveButtonState() {
        let movieTitleText = movieTitle.text ?? ""
        let movieReleaseDateText = movieReleaseDate.text ?? ""
        let movieRateText = movieRate.text ?? ""
        let movieOverviewText = movieOverview.text ?? ""
        
        saveBtn.isEnabled = !movieTitleText.isEmpty && !movieReleaseDateText.isEmpty && !movieRateText.isEmpty && !movieOverviewText.isEmpty
    }
    
    private var urlString: String = ""
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func goTowikipediaBtn(_ sender: UIButton) {
        let relatedUrl = "https://en.wikipedia.org/wiki/Main_Page"
        if let url = URL(string: relatedUrl){
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {
        guard let image = moviePosterImage.image else {return}
        let activityController = UIActivityViewController (activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            movieTitle.text = movie.title
            movieReleaseDate.text = convertDateFormater( movie.year )
            movieRate.text = String (movie.rate)
            movieOverview.text = movie.overview
            let poster = movie.posterImage
            
            urlString = "https://image.tmdb.org/t/p/w300" + poster
            
            guard let posterImageURL = URL(string: urlString) else {
                self.moviePosterImage.image = UIImage(named: "noImageAvailable")
                return
            }
            
            // Before we download the image we clear out the old one
            self.moviePosterImage.image = nil
            
            getImageDataFrom(url: posterImageURL)
        }
        
        updateSaveButtonState()
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePosterImage.image = image
                }
            }
        }.resume()
    }
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        
        return fixDate
    }
}
