//
//  ListUserViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 30/12/21.
//

import Foundation

class ListUserViewModel: ObservableObject {
    private let userService = UserService()
    @Published var users: [User] = []
    
    func getAllUser() {
        userService.getAllUser { result in
            if let result = result {
                self.users = result
            }
        }
    }
    
    func removeUser(userId: Int) {
        userService.removeUser(userId: userId) { code in
            if code == 200 {
                self.getAllUser()
            }
        }
        
    }
    
}
