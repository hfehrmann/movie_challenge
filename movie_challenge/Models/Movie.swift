//
//  Movie.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let overview: String
    let voteAvarage: Int
    let popularity: Int
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
}
