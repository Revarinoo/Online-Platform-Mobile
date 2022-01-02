//
//  ProductDetailModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import Foundation

struct ProductDetailModel: Identifiable {
    let id: UUID = UUID()
    let portfolio: [String]
    let category: String
    let seller_type: String
    let location: String
    let rating: Double
    let reviews: [ReviewModel]
    let description: String
    let user: ProductSeller
    let packages: [ProductPackage]
}

struct ReviewModel: Identifiable {
    let id = UUID()
    let name: String
    let comment: String
}

struct SellerProductDetail: Codable {
    let product: SellerProductData
    let portfolios: [String]
}

struct SellerProductData: Codable {
    let id: Int
    let category_id: String
    let description: String
    let package: [SellerPackageDetail]
}

struct SellerPackageDetail: Codable {
    let id: Int
    let price: Double
    let revision: Int
    let quantity: Int
    let type: String
    let high_resolution: Int
    let source_file: Int
    var commercial_use: Int
    let light_editing: Int
    
}
