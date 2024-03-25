//
//  UserListViewModel.swift
//  TestApp
//
//  Created by Apple on 3/23/24.
//

import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    
    
    @Published var pageCount: Int = 1
    @Published var users: [User]?
    @Published var userError: UserError?
    @Published var shouldShowAlert = false
    @Published var isLoading = false
    
    func getUsers(pageNo: Int) async {
        isLoading = true
        do {
            self.users = try await WebService.getUsers(pageNo: pageNo)
            self.isLoading = false
        } catch(let error) {
            userError = UserError.custom(error: error)
            shouldShowAlert = true
            isLoading = false
        }
    }
    
    func pageIncrement() {
        pageCount += 1
    }

    func pageDecrement() {
        pageCount -= 1
    }
    
}
