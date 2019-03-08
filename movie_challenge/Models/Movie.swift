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
    let rating: Float
    let popularity: Float
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case rating = "vote_average"
        case popularity = "popularit"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        rating = try container.decode(Float.self, forKey: .rating)
        popularity = try container.decode(Float.self, forKey: .popularity)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        posterPath = try container.decode(String?.self, forKey: .posterPath)
        backdropPath = try container.decode(String?.self, forKey: .backdropPath)
    }
}
