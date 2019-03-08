//
//  MovieListerViewModel.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 06-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieListerViewModel {
    var segmentTitle: Observable<(String, String)> { get }
    var isLoading: Observable<Bool> { get }
    var cellViewModel: Observable<[MovieListerTableCellViewModel]> { get }

    var segmentIndex: AnyObserver<Int> { get }
}

struct DefaultMovieListerViewModel: MovieListerViewModel {

    let segmentTitle: Observable<(String, String)>
    var isLoading: Observable<Bool>
    var cellViewModel: Observable<[MovieListerTableCellViewModel]>

    var segmentIndex: AnyObserver<Int> {
        get{ return self.publishSegmentIndex.asObserver() }
    }

    private let publishSegmentIndex: PublishSubject<Int>

    init(apiService: MovieApi) {
        let MovieLister = HFString.MovieLister.self
        let singleTitle = Single.just((MovieLister.FirstSegment, MovieLister.SecondSegment))
        self.segmentTitle = singleTitle.asObservable()

        let isLoading = BehaviorSubject<Bool>(value: false)
        self.publishSegmentIndex = PublishSubject()
        self.cellViewModel = self.publishSegmentIndex
            .flatMapLatest({ index -> Observable<[Movie]> in
                isLoading.onNext(true)
                let result: Single<[Movie]>
                if index == 0 {
                    result = apiService.getTopRatedMovies()
                } else {
                    result = apiService.getPopularMovies()
                }
                return result.asObservable()
            }).map({ movies in
                isLoading.onNext(false)
                return movies.map({ DefaultMovieListerTableCellViewModel(movie: $0, apiService: apiService) })
            })

        self.isLoading = isLoading

    }
}
