//
//  ProductDetailResponse.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import Foundation

struct ProductDetailResponse: Codable {
    let code: Int
    let message: String
    let portfolio: [String]
    let category: String
    let seller_type: String
    let location: String
    let rating: Double
    let reviews: [Review]
    let description: String
    let user: ProductSeller
    let packages: [ProductPackage]
}

struct Review: Codable {
    let name: String
    let comment: String
}

struct ProductSeller: Codable {
    let id: Int?
    let name: String?
    let photo: String?
}

struct ProductPackage: Codable {
    let id: Int?
    let price: Double?
    let revision: Int?
    let quantity: Int?
    let type: String?
    let high_resolution: Int?
    let source_file: Int?
    let commercial_use: Int?
    let light_editing: Int?
}

extension ProductPackage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
