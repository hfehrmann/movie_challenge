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
}

struct DefaultMovieListerTableCellViewModel: MovieListerTableCellViewModel {
    
}
