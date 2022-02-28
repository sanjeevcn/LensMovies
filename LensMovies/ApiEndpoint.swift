//
//  ApiEndpoint.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation

enum ApiEndpoint {
    case searchMovie(String, Int)
    
    var baseUrl: String {
        return "http://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    
    var description: String {
        return baseUrl + path
    }
    
    var apiKey: String {
        return "7e588fae3312be4835d4fcf73918a95f"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchMovie(let movie, let page):
            return [.init(name: "api_key", value: apiKey),
                    .init(name: "query", value: movie),
                    .init(name: "page", value: page.description),]
        }
    }
    
    var httpMethod: String {
        switch self {
        case .searchMovie:
            return "GET"
        }
    }
    
    var request: URLRequest {
        var urlComponents: URLComponents = URLComponents(string: baseUrl)!
        urlComponents.path = path
        
        if queryItems.count > 0 {
            urlComponents.queryItems = queryItems
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod
        
        if httpMethod == "POST" {}//POST Request body
        debugPrint(request)
        return request
    }
}

extension ApiEndpoint: Equatable {
    static func == (lhs: ApiEndpoint, rhs: ApiEndpoint) -> Bool {
        return lhs.path == rhs.path
    }
}
