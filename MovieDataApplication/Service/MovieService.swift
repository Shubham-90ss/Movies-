//
//  MovieService.swift
//  MovieDataApplication
//
//  Created by apple on 28/07/24.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    
    func loadMovies(completion: @escaping ([Movie]?) -> Void) {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            completion(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            completion(movies)
        } catch {
            print("Failed to load movies: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
