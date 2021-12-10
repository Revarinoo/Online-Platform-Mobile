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

struct Seller: Codable {
    let product_id: Int?
    let name: String?
    let photo: String?
    let seller_type: [String]?
    let rating: Double
}

extension Seller: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(product_id)
    }
}

struct UserProfile: Codable{
    var id: Int
    var name: String
    var photo: String
}
