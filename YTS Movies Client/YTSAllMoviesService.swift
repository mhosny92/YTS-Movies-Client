//
//  YTSAllMoviesService.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import Moya

enum YTSAllMoviesService{
    case showMoviesBy(page: Int)
    case showMoviesByPageAndLimit(page: Int, limit: Int)
}


extension YTSAllMoviesService: TargetType{
    var baseURL: URL{ return URL(string:"https://yts.am/api/v2/list_movies.json")!}
    var path: String {
        switch self {
        case .showMoviesBy(let page):
            return "?page=\(page)"
        case .showMoviesByPageAndLimit(let page, let limit):
            return "?page=\(page)&limit=\(limit)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .showMoviesBy, .showMoviesByPageAndLimit:
            return .get
        }
    }
    var task:Task {
        switch self {
        case .showMoviesBy, .showMoviesByPageAndLimit:
            return .requestPlain
        }
    }
    var sampleData: Data{
        switch self {
        case .showMoviesBy(let page):
            return "{\"id\": \(page)}".utf8Encoded
        case .showMoviesByPageAndLimit(page: let page, limit: let limit):
            return "page id \(page) and limit \(limit)".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
