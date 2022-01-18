//
//  LoginViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 14/10/21.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    @Published var name = ""
    @Published var email = ""
    @Published var failedMessage = ""
    @Published var isAuthenticated = false
    @Published var redBanner = false
    
    @AppStorage("JWT", store: .standard) var token = ""
    @AppStorage("role", store: .standard) var role = ""
    
    func login(role: Role) {
        if email == "" || password == "" {
            redBanner = true
            return
        }
        AuthService().login(loginRequestBody: LoginRequestBody(email: email, password: password, type_role: role.rawValue)) { response in
          
            if let code = response?.code, let message = response?.message {
                if code == 201, let access_token = response?.access_token {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        self.token = access_token
                        self.role = role.rawValue
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.redBanner = true
                        self.failedMessage = message
                    }
                }
            }
        }
    }
}
