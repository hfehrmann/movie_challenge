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
}

struct DefaultMovieListerTableCellViewModel: MovieListerTableCellViewModel {
    let title: Observable<String>
    let rating: Observable<Float>
    let popularity: Observable<Float>
    let imageData: Observable<Data>

    init(movie: Movie) {
        self.title = Single.just(movie.title).asObservable()
        self.rating = Single.just(movie.rating).asObservable()
        self.popularity = Single.just(movie.popularity).asObservable()
        self.imageData = Observable.just(Data())
    }
}
