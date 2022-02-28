//
//  CustomError.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation

enum CustomError: LocalizedError {
    case invalidUrl, invalidRequest, invalidResponse, custom(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Url incorrect"
        case .invalidRequest:
            return "Invalid Request"
        case .invalidResponse:
            return "Invalid Response"
        case .custom(let message): //Pass custom message
            return message
        }
    }
}
