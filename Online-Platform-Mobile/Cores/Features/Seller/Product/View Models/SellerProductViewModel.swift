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
    @Published var package: CreatePackageModel = CreatePackageModel()
    @Published var allPackage: [CreatePackageModel] = []
    @Published var showEmpty = false
    
    func validateField() -> Bool {
        if product.category != "" && product.description != "" && product.portfolios.count != 0 && allPackage.count != 0 {
            return true
        }
        
        return false
    }
    
    func createProduct() {
        if !validateField() {
            self.showEmpty = true
            return
        }
        productService.createProduct(productModel: self.product) { result, productId in
            if result == 200 {
                for (index, package) in self.allPackage.enumerated() {
                    self.productService.createPackage(productId: productId, package: package) { result in
                        if index == self.allPackage.count - 1 {
                            self.successfullyCreated = true
                        }
                    }
                }
            }
        }
    }
}
