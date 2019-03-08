//
//  MovieDetailViewModel.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 08-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailViewModel {
    var title: Observable<String> { get }
    var overview: Observable<String> { get }
    var rating: Observable<Float> { get }
    var popularity: Observable<Float> { get }
    var imageData: Observable<Data> { get }
}

struct DefaultMovieDetailViewModel: MovieDetailViewModel {

    let title: Observable<String>
    let overview: Observable<String>
    let rating: Observable<Float>
    let popularity: Observable<Float>
    let imageData: Observable<Data>

    init(movie: Movie, apiService: ApiService, cacheManager: CacheManager) {
        self.title = Single.just(movie.title).asObservable()
        self.overview = Single.just(movie.overview).asObservable()
        self.rating = Single.just(movie.rating).asObservable()
        self.popularity = Single.just(movie.popularity).asObservable()

        let dataImage: Observable<Data>
        if let posterPath = movie.posterPath {
            if let data = cacheManager.getData(forKey: posterPath) {
                dataImage = Observable.just(data)
            } else {
                dataImage = apiService
                    .getMovieImage(for: posterPath)
                    .asObservable()
                    .do(onNext: { cacheManager.setData(forKey: posterPath, data: $0)})
            }
        } else {
            dataImage = Observable.just(Data())
        }
        imageData = dataImage
    }
}
