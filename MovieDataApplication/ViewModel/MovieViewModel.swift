//
//  MovieViewModel.swift
//  MovieDataApplication
//
//  Created by apple on 28/07/24.
//

import Foundation

class MoviesViewModel {
    var allMovies: [Movie] = []
    var filteredMovies: [Movie] = []
    var years: [String] = []
    var genres: [String] = []
    var directors: [String] = []
    var actors: [String] = []
    var isSectionExpanded: [String: Bool] = ["Year": false, "Genre": false, "Director": false, "Actor": false, "All Movies": false]
    var searchActive = false

    func loadMovies(from json: String) {
        guard let path = Bundle.main.path(forResource: json, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            self.allMovies = movies
            self.years = Array(Set(movies.map { $0.year })).sorted()
            self.genres = Array(Set(movies.flatMap { $0.genre.components(separatedBy: ", ") })).sorted()
            self.directors = Array(Set(movies.map { $0.director })).sorted()
            self.actors = Array(Set(movies.compactMap { $0.actors })).sorted()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func toggleSection(_ section: String) {
        isSectionExpanded[section]?.toggle()
    }

    func filterMovies(by category: String, value: String) {
        switch category {
        case "Year":
            filteredMovies = allMovies.filter { $0.year == value }
        case "Genre":
            filteredMovies = allMovies.filter { $0.genre.contains(value) }
        case "Director":
            filteredMovies = allMovies.filter { $0.director == value }
        case "Actor":
            filteredMovies = allMovies.filter { $0.actors.contains(value) }
        default:
            break
        }
        searchActive = true
    }

    func clearSearch() {
        searchActive = false
        filteredMovies = []
    }

    func searchMovies(query: String) {
        filteredMovies = allMovies.filter {
            $0.title.contains(query) || $0.genre.contains(query) || $0.director.contains(query) || $0.actors.contains(query)
        }
    }
}
