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
    
}
