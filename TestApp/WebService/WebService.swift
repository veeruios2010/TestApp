//
//  WebService.swift
//  TestApp
//
//  Created by Apple on 3/23/24.
//

import Foundation

final class WebService {
    
    static func getUsers(pageNo: Int) async throws -> [User] {
        let urlString = "\(APIEndPoints.baseUrl)\(APIEndPoints.getUsersList)\(pageNo)"
        guard let url = URL(string: urlString) else {
            throw UserError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
            throw UserError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(UsersList.self, from: data).users
            
        } catch {
            throw UserError.invalidData
        }
    }
    
//    static func getUserInfo(withUserId: Int) async throws -> UserInfo {
//        let urlString = "\(APIEndPoints.baseUrl)\(APIEndPoints.getUser)\(withUserId)"
//        guard let url = URL(string: urlString) else {
//            throw UserError.invalidURL
//        }
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let response = response as? HTTPURLResponse,
//                response.statusCode == 200 else {
//            throw UserError.invalidResponse
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(UserInfo.self, from: data)
//
//        } catch {
//            throw UserError.invalidData
//        }
//    }
}
