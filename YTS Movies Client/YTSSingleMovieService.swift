//
//  YTSSingleMovieService.swift
//  YTS Movies Client
//
//  Created by Mahmoud Hosny on 12/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import Moya

enum YTSSingleMovieService{
    case showMovieBy(id: Int)
    case showMovieByIdAndImages(id: Int, withImage: Bool)
}


extension YTSSingleMovieService: TargetType{
    var baseURL: URL{ return URL(string:"https://yts.am/api/v2/movie_details.json")!}
    var path: String {
        switch self {
        case .showMovieBy(id: let id):
            return "?movie_id=\(id)"
        case .showMovieByIdAndImages(id: let id, withImage: let withImage):
            return "?movie_id=\(id)&with_images=\(withImage)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .showMovieBy, .showMovieByIdAndImages:
            return .get
        }
    }
    var task:Task {
        switch self {
        case .showMovieBy, .showMovieByIdAndImages:
            return .requestPlain
        }
    }
    var sampleData: Data{
        switch self {
        case .showMovieBy(let id):
            return "{\"id\": \(id)}".utf8Encoded
        case .showMovieByIdAndImages(id: let id, withImage: let withImage):
            return "page id \(id) and withImages \(withImage)".utf8Encoded
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

