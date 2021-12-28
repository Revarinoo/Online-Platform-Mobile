//
//  CreateProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 13/12/21.
//

import Foundation

class SellerProductViewModel: ObservableObject {
    @Published var product: CreateProductModel = CreateProductModel()
    private let productService = ProductService()
    @Published var successfullyCreated = false
    
    func createProduct() {
        productService.createProduct(productModel: self.product) { result in
            if result == 200 {
                self.successfullyCreated = true
            }
        }
    }
}
