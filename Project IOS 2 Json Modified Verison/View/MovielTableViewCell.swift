//
//  MovielTableViewCell.swift
//  Project IOS 2 Json Modified Verison
//
//  Created by Map04 on 2021-04-14.
//

import UIKit

class MovielTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    private var urlString: String = ""
    
    func setCellWithValuesOf( movie:Movie) {
        updateUI(title: movie.title, poster: movie.posterImage)
    }
    
    private func updateUI(title: String,  poster: String?) {
        self.movieNameLabel.text = title
        guard let posterString = poster else {return}
        
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        getImageDataFrom(url: posterImageURL)
    }
    
     func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
}
