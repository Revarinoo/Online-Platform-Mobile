//
//  MyProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 29/12/21.
//

import Foundation

class MyProductViewModel: ObservableObject {
    @Published var products: SellerProduct? = nil
    private let productService = ProductService()
    
    func getAllProduct() {
        productService.getSellerProducts { result in
            if let result = result {
                DispatchQueue.main.async {
                    self.products = result
                }
            }
        }
    }
}
