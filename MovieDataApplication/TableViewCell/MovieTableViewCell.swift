//
//  MovieTableViewCell.swift
//  MovieDataApplication
//
//  Created by apple on 27/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieThumbImg: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblReleaseYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
            lblMovieTitle.text = movie.title
            lblMovieLanguage.text = movie.language
            lblReleaseYear.text = movie.year
            
            if let url = URL(string: movie.poster) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.movieThumbImg.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    
}

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

