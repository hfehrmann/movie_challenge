//
//  ApiResponse.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 08-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

struct ApiResponse<A: Codable>: Codable {
    let results: [A]
}
