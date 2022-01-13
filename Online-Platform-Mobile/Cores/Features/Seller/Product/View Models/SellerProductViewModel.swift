//
//  CreateProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 13/12/21.
//

import Foundation
import SwiftUI
import CoreML

class SellerProductViewModel: ObservableObject {
    @Published var product: CreateProductModel = CreateProductModel()
    private let productService = ProductService()
    @Published var successfullyCreated = false
    @Published var package: CreatePackageModel = CreatePackageModel()
    @Published var allPackage: [CreatePackageModel] = []
    @Published var showEmpty = false
    @Published var categories: [String] = []
    @Published var finishLoad = false
    @Published var result: [String] = []
    
    func imageChecker(portfolios: [UIImage]) {
        for image in portfolios {
            if let resizedImage = image.resizeImageTo(size: CGSize(width: 224, height: 224)), let buffer = resizedImage.convertToBuffer() {
                
                do {
                    let config = MLModelConfiguration()
                    let model = try CategoryClassifier_2(configuration: config)
                    let input = CategoryClassifier_2Input(image: buffer)
                    let output = try model.prediction(input: input)
                    let hasil = output.classLabel
                    print(output.classLabelProbs.description)
                    result.append(hasil)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
        }
    }
    
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
        self.imageChecker(portfolios: self.product.portfolios)
        productService.createProduct(productModel: self.product) { result, productId in
            if result == 200 {
                for (index, package) in self.allPackage.enumerated() {
                    self.productService.createPackage(productId: productId, package: package, suggestions: self.result) { result in
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
