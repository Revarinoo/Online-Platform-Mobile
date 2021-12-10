//
//  RegisterViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/10/21.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Published var password = ""
    @Published var name = ""
    @Published var email = ""
    @Published var isAuthenticated = false
    @Published var redBanner = false
    @Published var failedMessage = ""
    
    @AppStorage("JWT", store: .standard) var token = ""
    @AppStorage("role", store: .standard) var role = ""
    
    func register(role: Role) {
        AuthService().register(registerRequestBody: RegisterRequestBody(name: name, email: email, password: password, type_role: role.rawValue)) { response in
          
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
