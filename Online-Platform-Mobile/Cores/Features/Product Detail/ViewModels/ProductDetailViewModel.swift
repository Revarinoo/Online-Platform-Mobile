//
//  ProductDetailViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    static let shared = ProductDetailViewModel()
    private let detailService = ProductDetailService()
    @Published var productDetailModel: ProductDetailModel = ProductDetailModel(portfolio: [""], category: "", seller_type: "", location: "", rating: 0.0, reviews: [Review(name: "", comment: "")], description: "", user: ProductSeller(id: 1, name: "", photo: ""), packages: [ProductPackage(id: 0, price: 0, revision: 0, quantity: 0, type: "", high_resolution: 0, source_file: 0, commercial_use: 0, editing: 0)])
    
    func refresh(productId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.065) {
            self.getDetail(productId: productId)
        }
    }
    
    func getDetail(productId: Int) {
        detailService.getProductDetail(productId: productId) { result in
            if let response = result {
                DispatchQueue.main.async {
                    self.productDetailModel = ProductDetailModel(portfolio: response.portfolio, category: response.category, seller_type: response.seller_type, location: response.location, rating: response.rating, reviews: response.reviews, description: response.description, user: response.user, packages: response.packages)
                }
            }
        }
    }
}
