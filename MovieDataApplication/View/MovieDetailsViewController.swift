//
//  MovieDetailsViewController.swift
//  MovieDataApplication
//
//  Created by apple on 28/07/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var lblTitleYear: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var ratingSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var ratingView: RatingView!
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    private func configureView() {
        // Ensure the movie is not nil
        guard let movie = movie else { return }
        
        // Set labels with the movie's details
        lblTitleYear.text = movie.title
        lblPlot.text = movie.plot
        lblCast.text = "Cast & Crew: \(movie.actors)"
        lblReleaseDate.text = "Release Date: \(movie.released)"
        lblGenre.text = "Genre: \(movie.genre)"
       
        ratingSegmentControl.removeAllSegments()
        
        for (index, rating) in movie.ratings.enumerated() {
            ratingSegmentControl.insertSegment(withTitle: rating.source, at: index, animated: false)
        }
       
        updateRating(for: 0)
        if let url = URL(string: movie.poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    
    @IBAction func ratingSourceChanged(_ sender: UISegmentedControl) {
        updateRating(for: sender.selectedSegmentIndex)
    }
    
    private func updateRating(for index: Int) {
        if index < movie?.ratings.count ?? 0 {
            let rating = movie?.ratings[index]
            ratingView.ratingValue = rating?.value
        }
    }
   
}
