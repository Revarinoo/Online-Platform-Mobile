//
//  ProductModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 29/12/21.
//

import Foundation

struct SellerProduct: Codable {
    let data: [SellerProductResponse]
    let code: Int
    let message: String
}

struct SellerProductResponse: Codable, Identifiable {
    let id: Int
    let category: String
    let icon: String
}

struct SellerResponse: Codable {
    let data: [Seller]?
    let message: String?
    let code: Int?
}

struct CreateProductResponse: Codable {
    let product_id: Int
    let code: Int
    let message: String
}


