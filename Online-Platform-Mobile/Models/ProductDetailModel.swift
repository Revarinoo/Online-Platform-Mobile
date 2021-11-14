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
    let reviews: [Review]
    let description: String
    let user: ProductSeller
    let packages: [ProductPackage]
}
