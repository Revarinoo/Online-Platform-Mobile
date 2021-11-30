//
//  ProductDetailViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    private let detailService = ProductDetailService()
    @Published var productDetailModel: ProductDetailModel = ProductDetailModel(portfolio: [""], category: "", seller_type: "", location: "", rating: 0.0, reviews: [ReviewModel(name: "", comment: "")], description: "", user: ProductSeller(id: 1, name: "", photo: ""), packages: [ProductPackage(id: 0, price: 0, revision: 0, quantity: 0, type: "", high_resolution: 0, source_file: 0, commercial_use: 0, light_editing: 0)])
    
    func refresh(productId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            self.getDetail(productId: productId)
        }
    }
    
    func getDetail(productId: Int) {
        detailService.getProductDetail(productId: productId) { result in
            if let response = result {
                var tempReviews: [ReviewModel] = []
                for review in response.reviews {
                    tempReviews.append(ReviewModel(name: review.name, comment: review.comment))
                }
                DispatchQueue.main.async {
                    self.productDetailModel = ProductDetailModel(portfolio: response.portfolio, category: response.category, seller_type: response.seller_type, location: response.location, rating: response.rating, reviews: tempReviews, description: response.description, user: response.user, packages: response.packages)
                }
            }
        }
    }
    
    func calculateCart(carts: [ProductPackage]) -> String {
        var total = 0
        for cart in carts {
            total += Int(cart.price!)
        }
        return total.rupiahFormatter()
    }
}
