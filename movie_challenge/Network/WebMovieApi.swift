//
//  WebMovieApi.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import Moya

private enum MovieMoya {
    case topRated
    case popular
    case image(Movie)
}

extension MovieMoya: TargetType {
    var baseURL: URL {
        
    }

    var path: String {
        <#code#>
    }

    var method: Method {
        <#code#>
    }

    var sampleData: Data {
        <#code#>
    }

    var task: Task {
        <#code#>
    }

    var headers: [String : String]? {
        <#code#>
    }



}

class WebMovieApi {

    private let provider: MoyaProvider<MovieMoya>

    init(){
        provider = MoyaProvider<MovieMoya>()
    }
}
