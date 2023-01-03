//
//  ImagesTarget.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 3.01.23.
//

import Foundation
import Moya

enum ImagesTarget {
    case fetchRandomPhotos(count: Int)
    case searchPhotos(query: String, page: String, perPage: String)
}

extension ImagesTarget: TargetType {
    
    var task: Task {
        switch self {
        case .fetchRandomPhotos(let count):
            return .requestParameters(parameters: ["count": count],
                                      encoding: URLEncoding.queryString)
        case let .searchPhotos(query, page, perPage):
            return .requestParameters(parameters: ["query": query, "page": page, "per_page": perPage],
                                      encoding: URLEncoding.queryString)
        }
        
    }
    
    var path: String {
        switch self {
        case .fetchRandomPhotos:
            return "/photos/random/"
        case .searchPhotos:
            return "/search/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchRandomPhotos:
            return .get
        case .searchPhotos:
            return .get
        }
    }
}
