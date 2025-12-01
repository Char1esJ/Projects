//
//  MoviesModel.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/20/25.
//

import UIKit

class MoviesViewModel {
    private var movies = [
        MovieModel(
            poster: UIImage(named: "SpidermanPoster"),
            rating: "9.1/10 IMDb",
            title: "Spiderman: No Way\nHome",
            genres: ["Action", "Adventure", "Fantasy"],
            duration: "2h 28m",
            cast: [
                Cast(name: "Tom Holland", profileImage: UIImage(named: "Tom")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Benedict Cumberbatch", profileImage: UIImage(named: "Benedict")),
                Cast(name: "Jacon Batalon", profileImage: UIImage(named: "Jacon"))
            ],
            description: "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: true,
            isPopular: false
        ),
        
        MovieModel(
            poster: UIImage(named: "EternalsPoster"),
            rating: "9.5/10 IMDb",
            title: "Eternals",
            genres: ["Action", "Adventure", "Drama"],
            duration: "2h 36m",
            cast: [
                Cast(name: "Gemma Chan", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Richard Madden", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Angelina Jolie", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
            ],
            description: "The Eternals, an immortal alien race, emerge from hiding after thousands of years to protect Earth from their evil counterparts, the Deviants.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: true,
            isPopular: false
        ),
        
        MovieModel(
            poster: UIImage(named: "ShangchiPoster"),
            rating: "8.1/10 IMDb",
            title: "Shang-Chi",
            genres: ["Action", "Adventure", "Fantasy"],
            duration: "2h 12m",
            cast: [
                Cast(name: "Simu Liu", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Awkwafina", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Tony Leung", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
            ],
            description: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: true,
            isPopular: true
        ),
        
        MovieModel(
            poster: UIImage(named: "VenomPoster"),
            rating: "6.4/10 IMDb",
            title: "Venom: Let There Be Carnage",
            genres: ["Horror", "Mystery"],
            duration: "1h 47m",
            cast: [
                Cast(name: "Tom Hardy", profileImage: UIImage(named: "TomHardy")),
                Cast(name: "Woody Harrelson", profileImage: UIImage(named: "WoodyHarrelson")),
                Cast(name: "Michelle Williams", profileImage: UIImage(named: "MichelleWilliams")),
                Cast(name: "Riz Ahmed", profileImage: UIImage(named: "RizAhmed"))
            ],
            description: "Eddie Brock attempts to reignite his career by interviewing serial killer Cletus Kasady, who becomes the host of the symbiote Carnage and escapes prison after a failed execution.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: false,
            isPopular: true
        ),
        
        MovieModel(
            poster: UIImage(named: "KingsmanPoster"),
            rating: "8.4/10 IMDb",
            title: "The King's Man",
            genres: ["Action", "Adventure", "Thriller"],
            duration: "2h 11m",
            cast: [
                Cast(name: "Ralph Fiennes", profileImage: UIImage(named: "RalphFiennes")),
                Cast(name: "Gemma Arterton", profileImage: UIImage(named: "GemmaArterton")),
                Cast(name: "Rhys Ifans", profileImage: UIImage(named: "RhysIfans")),
                Cast(name: "Taron Egerton", profileImage: UIImage(named: "TaronEgerton")),
            ],
            description: "In the early years of the 20th century, the Kingsman agency is formed to stand against a cabal plotting a war to wipe out millions.",
            language: "English",
            pgRating: "R",
            isNowShowing: false,
            isPopular: true
        ),
        
        MovieModel(
            poster: UIImage(named: "DunePoster"),
            rating: "8.0/10 IMDb",
            title: "Dune",
            genres: ["Sci-Fi", "Adventure", "Drama"],
            duration: "2h 35m",
            cast: [
                Cast(name: "Timothée Chalamet", profileImage: UIImage(named: "TimotheeChalamet")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Oscar Isaac", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
            ],
            description: "Paul Atreides arrives on Arrakis after his father accepts the stewardship of the dangerous planet. However, chaos ensues after a betrayal as forces clash to control melange, a precious resource.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: true,
            isPopular: true
        ),
        
        MovieModel(
            poster: UIImage(named: "NoTimeToDiePoster"),
            rating: "7.3/10 IMDb",
            title: "No Time To Die",
            genres: ["Action", "Adventure", "Thriller"],
            duration: "2h 43m",
            cast: [
                Cast(name: "Daniel Craig", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Rami Malek", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Léa Seydoux", profileImage: UIImage(named: "Zendaya")),
                Cast(name: "Zendaya", profileImage: UIImage(named: "Zendaya")),
            ],
            description: "James Bond has left active service. His peace is short-lived when Felix Leiter, an old friend from the CIA, turns up asking for help, leading Bond onto the trail of a mysterious villain.",
            language: "English",
            pgRating: "PG-13",
            isNowShowing: false,
            isPopular: true
        )
    ]
    
    var nowShowingMovies: [MovieModel] {
        return movies.filter { $0.isNowShowing }
    }
    
    var numberOfNowShowingMovies: Int {
        return nowShowingMovies.count
    }
    
    func nowShowingMovie(at index: Int) -> MovieModel {
        return nowShowingMovies[index]
    }
    
    var popularMovies: [MovieModel] {
        return movies.filter { $0.isPopular }
    }
    
    var numberOfPopularMovies: Int {
        return popularMovies.count
    }
    
    func popularMovie(at index: Int) -> MovieModel {
        return popularMovies[index]
    }
}
