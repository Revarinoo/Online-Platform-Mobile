//
//  RegisterViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/10/21.
//

import Foundation

class RegisterViewModel: ObservableObject {
    static let shared = RegisterViewModel()
    @Published var password = ""
    @Published var name = ""
    @Published var email = ""
    @Published var isAuthenticated = false
    @Published var redBanner = false
    @Published var failedMessage = ""
    
    func Register(role: Role) {
        let defaults = UserDefaults.standard
        
        RegisterService().Register(name: name, email: email, password: password, type_role: role) { result in
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
