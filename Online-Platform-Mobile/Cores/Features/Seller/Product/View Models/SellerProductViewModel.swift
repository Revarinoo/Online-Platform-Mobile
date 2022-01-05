//
//  CreateProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 13/12/21.
//

import Foundation
import SwiftUI

class SellerProductViewModel: ObservableObject {
    @Published var product: CreateProductModel = CreateProductModel()
    private let productService = ProductService()
    @Published var successfullyCreated = false
    @Published var package: CreatePackageModel = CreatePackageModel()
    @Published var allPackage: [CreatePackageModel] = []
    @Published var showEmpty = false
    @Published var categories: [String] = []
    @Published var finishLoad = false
    
    func validateField() -> Bool {
        if product.category != "" && product.description != "" && product.portfolios.count != 0 && allPackage.count != 0 && product.category != "Choose" {
            return true
        }
        return false
    }
    
    func validatePackage() -> Bool {
        return package.price == "" ? false : true
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
    
    func getSellerProductDetail(productId: Int) {
        productService.getSellerProductDetail(productId: productId) { result in
            if let result = result {
                var portfolios: [UIImage] = []
                for portfolio in result.portfolios {
                    if let data = try? Data(contentsOf: URL(string: portfolio)!) {
                        let image: UIImage = UIImage(data: data)!
                        portfolios.append(image)
                    }
                }
                self.product = CreateProductModel(category: result.product.category_id, description: result.product.description, portfolios: portfolios)
                
                var packages: [CreatePackageModel] = []
                for data in result.product.package {
                    packages.append(CreatePackageModel(type: data.type, price: String(Int(data.price)), quantity: data.quantity, highResolution: data.high_resolution == 1 ? true : false, sourceFile: data.source_file == 1 ? true : false, commercial: data.commercial_use == 1 ? true : false, editing: data.light_editing == 1 ? true : false, revision: data.revision))
                }
                self.allPackage = packages
                self.finishLoad = true
            }
        }
    }
    
    func updateProduct(productId: Int) {
        productService.updateProduct(productId: productId, productModel: self.product) { statusCode in
            if statusCode == 200 {
                self.successfullyCreated = true
                self.getSellerProductDetail(productId: productId)
            }
        }
    }
    
    func getCategories() {
        Homeservice().getCategories { result in
            if let result = result {
                if let categoriesResponse = result.categories {
                    DispatchQueue.main.async {
                        for data in categoriesResponse {
                            self.categories.append(data.name!)
                        }
                    }
                }
            }
        }
    }
}
