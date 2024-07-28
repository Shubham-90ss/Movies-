//
//  FilterDetailsViewController.swift
//  MovieDataApplication
//
//  Created by apple on 28/07/24.
//

import UIKit

class FilterDetailsViewController: UIViewController {

    @IBOutlet weak var filteredMoviesTableView: UITableView!
    var filteredMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        filteredMoviesTableView.dataSource = self
        filteredMoviesTableView.delegate = self
        filteredMoviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilteredMovieCell")
    }

}

extension  FilterDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilteredMovieCell", for: indexPath)
        let movie = filteredMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        // Configure cell for movie (add more details as needed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        showMovieDetails(movie)
    }
    
    private func showMovieDetails(_ movie: Movie) {
        let movieDetailsVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        movieDetailsVC.movie = movie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
