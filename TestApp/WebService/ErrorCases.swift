//
//  ErrorCases.swift
//  TestApp
//
//  Created by Apple on 3/23/24.
//

import Foundation

enum UserError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid data"
            
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
