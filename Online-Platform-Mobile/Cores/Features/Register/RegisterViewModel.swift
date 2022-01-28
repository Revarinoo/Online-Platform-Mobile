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
        if password.isEmpty || name.isEmpty || email.isEmpty {
            redBanner = true
            return
        }
        if !isValidEmail(value: email) {
            self.failedMessage = "Email format is incorrect!"
            redBanner = true
            return
        }
        if password.count < 6 {
            self.failedMessage = "Password must have minimum 6 character!"
            redBanner = true
            return
        }
        
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
    
    private func isValidEmail(value: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
}
