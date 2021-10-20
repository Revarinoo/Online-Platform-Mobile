//
//  RegisterService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 12/10/21.
//

import Foundation

struct RegisterRequestBody: Codable {
    let name: String
    let email: String
    let password: String
    let type_role: String
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let type_role: String
}


class AuthService {
    
    func register(registerRequestBody: RegisterRequestBody, completionHandler:@escaping(_ result: AuthResponse?)->Void) {
        guard let url = URL(string: "\(HttpService.endpoint)register") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(registerRequestBody)

        HttpService.shared.request(request, resultType: AuthResponse.self) { response in
            completionHandler(response)
        }
    }
    
    func login(loginRequestBody: LoginRequestBody, completionHandler:@escaping(_ result: AuthResponse?)->Void) {
        guard let url = URL(string: "\(HttpService.endpoint)login") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginRequestBody)
        
        HttpService.shared.request(request, resultType: AuthResponse.self) { result in
            completionHandler(result)
        }
    }
    
}
