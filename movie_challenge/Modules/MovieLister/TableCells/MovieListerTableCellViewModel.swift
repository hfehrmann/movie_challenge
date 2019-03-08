//
//  MovieListerTableCellViewModel.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieListerTableCellViewModel {
    var title: Observable<String> { get }
    var rating: Observable<Float> { get }
    var popularity: Observable<Float> { get }
    var imageData: Observable<Data> { get }

    func createDetailViewModel() -> MovieDetailViewModel
}

struct DefaultMovieListerTableCellViewModel: MovieListerTableCellViewModel {
    let title: Observable<String>
    let rating: Observable<Float>
    let popularity: Observable<Float>
    let imageData: Observable<Data>

    private let movie: Movie
    private let apiService: ApiService
    private let cacheManager: CacheManager

    init(movie: Movie, apiService: ApiService, cacheManager: CacheManager ) {
        self.title = Single.just(movie.title).asObservable()
        self.rating = Single.just(movie.rating).asObservable()
        self.popularity = Single.just(movie.popularity).asObservable()

        let dataImage: Observable<Data>
        if let backdropPath = movie.backdropPath {
            if let data = cacheManager.getData(forKey: backdropPath) {
                dataImage = Observable.just(data)
            } else {
                dataImage = apiService
                    .getMovieImage(for: backdropPath)
                    .asObservable()
                    .do(onNext: { cacheManager.setData(forKey: backdropPath, data: $0)})
            }
        } else {
            dataImage = Observable.just(Data())
        }
        imageData = dataImage
        self.movie = movie
        self.apiService = apiService
        self.cacheManager = cacheManager
    }

    func createDetailViewModel() -> MovieDetailViewModel {
        return DefaultMovieDetailViewModel(movie: movie, apiService: apiService, cacheManager: cacheManager)
    }
}
