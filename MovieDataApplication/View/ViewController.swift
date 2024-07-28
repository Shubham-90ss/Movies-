//
//  ViewController.swift
//  MovieDataApplication
//
//  Created by apple on 27/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieListTblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
      private var viewModel = MoviesViewModel()
      let sections = ["Year", "Genre", "Director", "Actor", "All Movies"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        movieListTblView.dataSource = self
        movieListTblView.delegate = self
        searchBar.delegate = self
        viewModel.loadMovies(from: "movies")
        movieListTblView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieListTblView.register(nib, forCellReuseIdentifier: "MovieCell")
                
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = sections[section]
        if viewModel.searchActive {
            return viewModel.filteredMovies.count
        } else {
            switch sectionName {
            case "Year":
                return viewModel.isSectionExpanded[sectionName] ?? false ? viewModel.years.count : 0
            case "Genre":
                return viewModel.isSectionExpanded[sectionName] ?? false ? viewModel.genres.count : 0
            case "Director":
                return viewModel.isSectionExpanded[sectionName] ?? false ? viewModel.directors.count : 0
            case "Actor":
                return viewModel.isSectionExpanded[sectionName]  ?? false ? viewModel.actors.count : 0
            case "All Movies":
                return viewModel.isSectionExpanded[sectionName] ?? false ? viewModel.allMovies.count : 0
            default:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let sectionName = sections[indexPath.section]
            if viewModel.searchActive || sectionName == "All Movies" {
                let cell = movieListTblView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
                let movie = viewModel.searchActive ? viewModel.filteredMovies[indexPath.row] : viewModel.allMovies[indexPath.row]
                cell.configure(with: movie)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
                let value: String
                switch sectionName {
                case "Year":
                    value = viewModel.years[indexPath.row]
                case "Genre":
                    value = viewModel.genres[indexPath.row]
                case "Director":
                    value = viewModel.directors[indexPath.row]
                case "Actor":
                    value = viewModel.actors[indexPath.row]
                default:
                    value = ""
                }
                cell.textLabel?.text = value
                return cell
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let sectionName = sections[indexPath.section]
            if viewModel.searchActive || sectionName == "All Movies" {
                let movie = viewModel.searchActive ? viewModel.filteredMovies[indexPath.row] : viewModel.allMovies[indexPath.row]
                print("Selected movie: \(movie)")
                showMovieDetails(movie)
            } else {
                let value: String
                switch sectionName {
                case "Year":
                    value = viewModel.years[indexPath.row]
                case "Genre":
                    value = viewModel.genres[indexPath.row]
                case "Director":
                    value = viewModel.directors[indexPath.row]
                case "Actor":
                    value = viewModel.actors[indexPath.row]
                default:
                    return
                }
                viewModel.filterMovies(by: sectionName, value: value)
                showFilteredMoviesList()
            }
        }

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if viewModel.searchActive { return nil }
            
            let headerView = UITableViewHeaderFooterView()
            headerView.textLabel?.text = sections[section]
            headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionTap(_:))))
            headerView.tag = section
            return headerView
        }

        @objc func handleSectionTap(_ gestureRecognizer: UITapGestureRecognizer) {
            if let section = gestureRecognizer.view?.tag {
                let sectionName = sections[section]
                viewModel.toggleSection(sectionName)
                movieListTblView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }

        private func showMovieDetails(_ movie: Movie) {
            let movieDetailsVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
            movieDetailsVC.movie = movie
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    
    private func showFilteredMoviesList() {
            let filteredMoviesVC = FilterDetailsViewController()
            filteredMoviesVC.filteredMovies = viewModel.filteredMovies
            navigationController?.pushViewController(filteredMoviesVC, animated: true)
        }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                viewModel.clearSearch()
                movieListTblView.reloadData()
            } else {
                viewModel.searchMovies(query: searchText)
                viewModel.searchActive = true
                movieListTblView.reloadData()
            }
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            viewModel.clearSearch()
            movieListTblView.reloadData()
        }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}




