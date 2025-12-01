//
//  MovieDetailViewModel.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class MovieDetailViewModel {
    // MARK: - Properties
    private let movie: MovieModel
    
    // MARK: - Init
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    var posterImage: UIImage? {
        movie.poster
    }
    
    var title: String {
        movie.title
    }
    
    var rating: String {
        movie.rating
    }
    
    var genres: [String] {
        movie.genres
    }
    
    var duration: String {
        movie.duration
    }
    
    var language: String {
        movie.language
    }
    
    var pgRating: String {
        movie.pgRating
    }
    
    var description: String {
        movie.description
    }
    
    var cast: [Cast] {
        movie.cast
    }
}
