//
//  ProductModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 29/12/21.
//

import Foundation

struct SellerProduct: Codable {
    var data: [SellerProductResponse] = []
    var code: Int = Int()
    var message: String = String()
}

struct SellerProductResponse: Codable, Identifiable {
    var id: Int = Int()
    var category: String = String()
    var icon: String = String()
    var status = String()
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

struct OrderReviewModel: Codable {
    var user_photo = String()
    var user_name = String()
    var rating = Int()
    var comment = String()
}

struct PortfoliosModel: Codable, Identifiable {
    var id = Int()
    var image = String()
    var category_suggestion = String()
}
