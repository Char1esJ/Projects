//
//  MovieModel.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/20/25.
//

import UIKit

struct MovieModel {
    let poster: UIImage?
    let rating: String
    let title: String
    let genres: [String]
    let duration: String
    
    let cast: [Cast]
    let description: String
    let language: String
    let pgRating: String
    
    let isNowShowing: Bool
    let isPopular: Bool
}

struct Cast {
    let name: String
    let profileImage: UIImage?
}
