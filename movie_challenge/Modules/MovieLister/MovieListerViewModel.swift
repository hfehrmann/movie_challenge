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

    var segmentIndex: AnyObserver<Int>

    init() {
        let MovieLister = HFString.MovieLister.self
        let singleTitle = Single.just((MovieLister.FirstSegment, MovieLister.SecondSegment))
        self.segmentTitle = singleTitle.asObservable()

        let isLoading = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .map({ $0 % 2 == 0 })

        self.segmentIndex = PublishSubject().asObserver()
        self.cellViewModel = PublishSubject()

        self.isLoading = isLoading
    }
}
