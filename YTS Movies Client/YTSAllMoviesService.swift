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
    // In case of allowing the user to view all the movies
    // Paging is used when the user scrolls down
    case showMoviesBy(page: Int)
    
    // In case of searching for a certain movie name.
    // Paging is used when the user scrolls down
    case searchMoviesBy(name: String, page: Int)
    
    // In case of allowing the user to view all the movies
    // Inteded to use if the user connection is fast (limit = 50)
    // Paging is used when the user scrolls down
    case showMoviesByPageAndLimit(page: Int, limit: Int)
}


extension YTSAllMoviesService: TargetType{
    // base api request URL
    var baseURL: URL{ return URL(string:"https://yts.am/api/v2/")!}
    var path: String {
        switch self {
        // All requests use list_movies api
        case .showMoviesBy, .showMoviesByPageAndLimit, .searchMoviesBy:
            return "list_movies.json/"
        }
    }
    
    var method: Moya.Method{
        switch self {
        // We are not POSTing anything in this project
        case .showMoviesBy, .showMoviesByPageAndLimit, .searchMoviesBy:
            return .get
        }
    }
    
    /*
     Adding HTTP request parameters to each call we have
     */
    var task:Task {
        var params: [String: Any] = [:]
        switch self {
        case .showMoviesBy(let page):
            params["page"] = page
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .showMoviesByPageAndLimit(let page, let limit):
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .searchMoviesBy(let name, let page):
            params["query_term"] = name
            params["page"] = page
            params["limit"] = 50
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        }
    }
    
    /*
     Sample request data.
     */
    var sampleData: Data{
        switch self {
        case .showMoviesBy(let page):
            return "{\"id\": \(page)}".utf8Encoded
        case .showMoviesByPageAndLimit(let page, let limit):
            return "page id \(page) and limit \(limit)".utf8Encoded
        case .searchMoviesBy(let name, let page):
            return "query_term \(name) page \(page)".utf8Encoded
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
