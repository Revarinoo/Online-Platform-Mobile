//
//  RegisterResponse.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/10/21.
//

import Foundation

struct AuthResponse: Codable {
    let code: Int?
    let message: String?
    let access_token: String?
}
