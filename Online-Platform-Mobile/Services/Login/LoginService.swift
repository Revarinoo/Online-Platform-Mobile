//
//  LoginService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 12/10/21.
//

import Foundation

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let type_role: String
}

struct LoginResponse: Codable {
    let user: User?
    let access_token: String?
    let message: String?
    let success: Bool?
}

class LoginService {
    
    func Login(email: String, password: String, type_role: Role, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password, type_role: type_role.rawValue)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidEmail))
                return
            }
            guard let token = loginResponse.access_token else {
                completion(.failure(.emailUsed))
                return
            }
            
            completion(.success(token))
            
        }.resume()
    }
}

