//
//  WebMovieApi.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import RxSwift
import Moya

private enum MovieMoya {
    case topRated
    case popular
    case image(String)
}

extension MovieMoya: TargetType {

    var headers: [String : String]? {
        return nil
    }

    var baseURL: URL {
        let urlString: String
        switch self {
        case .image:
            urlString = Constant.MOVIE_IMAGE_API
        case .topRated:
            fallthrough
        case .popular:
            urlString = Constant.MOVIE_API
        }
        guard let url = URL(string: urlString) else {
            fatalError("Bad formed url")
        }
        return url
    }

    var path: String {
        let path: String
        switch self {
        case .topRated:
            path = "top_rated"
        case .popular:
            path = "popular"
        case .image(let urlString):
            path = urlString
        }
        return path
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        let task: Task
        switch self {
        case .image:
            task = .requestPlain
        case .topRated:
            fallthrough
        case .popular:
            let parameters: [String: Any] = ["api_key": Constant.API_KEY]
            task = .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return task
    }
}

protocol ApiService {
    func getTopRatedMovies() -> Single<[Movie]>
    func getPopularMovies() -> Single<[Movie]>
    func getMovieImage(for: String) -> Single<Data>
}

class WebApiService: ApiService {

    private let provider: MoyaProvider<MovieMoya>

    init(){
        provider = MoyaProvider<MovieMoya>()
    }

    func getTopRatedMovies() -> Single<[Movie]> {
        return provider.rx.request(.topRated)
            .map(ApiResponse<Movie>.self)
            .map({ $0.results })
    }
    

    func getPopularMovies() -> Single<[Movie]> {
        return provider.rx.request(.popular)
            .map(ApiResponse<Movie>.self)
            .map({ $0.results })
    }

    func getMovieImage(for path: String) -> Single<Data> {
        return provider.rx.request(.image(path)).map({ $0.data })
    }
}
