//
//  RegisterService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 12/10/21.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct RegisterRequestBody: Codable {
    let name: String
    let email: String
    let password: String
    let type_role: String
}

struct RegisterResponse: Codable {
    let user: User?
    let access_token: String?
    let message: String?
    let success: Bool?
}

class RegisterService {
    
    func Register(name: String, email: String, password: String, type_role: Role, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/register") else {
            completion(.failure(.custom(errorMessage: "Wrong URL")))
            return
        }
        
        let body = RegisterRequestBody(name: name, email: email, password: password, type_role: type_role.rawValue)
        print("HEHEHEHE \(body)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No Data")))
                return
            }
            print(data)
            try! JSONDecoder().decode(RegisterResponse.self, from: data)
            guard let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print(registerResponse.message)
            guard let token = registerResponse.access_token else {
                completion(.failure(.custom(errorMessage: "No Token Found")))
                return
            }
            
            completion(.success(token))
            
        }.resume()
    }
}
