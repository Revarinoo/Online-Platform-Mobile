//
//  User.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 12/10/21.
//

import Foundation

enum Role: String, CaseIterable, Equatable {
    case Client = "Client"
    case Seller = "Seller"
    
}

struct User: Codable {
    let name: String
    let email: String
    let type_role: String
    let updated_at: String?
    let created_at: String?
    let id: Int
}

