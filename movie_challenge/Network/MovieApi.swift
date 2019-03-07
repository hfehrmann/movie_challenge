//
//  MovieApi.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieApi {
    func getTopRatedMovies() -> Single<[Movie]>
    func getPopularMovies() -> Single<[Movie]>
    func getMovieImage(for: String) -> Single<Data>
}
