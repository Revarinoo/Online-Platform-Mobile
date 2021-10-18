//
//  LoginViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 14/10/21.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    @Published var name = ""
    @Published var email = ""
    @Published var failedMessage = ""
    @Published var isAuthenticated = false
    @Published var redBanner = false
    
    func Login(role: Role) {
        let defaults =  UserDefaults.standard
        print(email)
        LoginService().Login(email: email, password: password, type_role: role) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "JWT")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.failedMessage = String("\(error)")
                    self.redBanner = true
                }
                print(error)
                
            }
        }
    }
}
