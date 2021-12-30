//
//  AdminProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 30/12/21.
//

import Foundation

class AdminProductViewModel: ObservableObject {
    private let productService = ProductService()
    @Published var products: SellerProduct = SellerProduct()
    
    func getAllSellerProduct(userId: Int) {
        productService.getAllSellerProduct(userId: userId) { result in
            if let result = result {
                if result.code == 200 {
                    self.products = result
                }
            }
        }
    }
    
    func removeProduct(productId: Int, userId: Int) {
        productService.removeProduct(productId: productId) { code in
            if code == 200 {
                self.getAllSellerProduct(userId: userId)
            }
        }
    }
}
