//
//  ProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/11/21.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @AppStorage("JWT", store: .standard) var token = ""
    
    @Published var selectedCategory:Int = 1
    @Published var categories: [Category] = []
    @Published var seller: [Seller] = []
    
    init() {
        fetchSeller(catId: selectedCategory)
    }
    
    func fetchSeller(catId: Int) {
        ProductService().getSeller(categoryId: catId) { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.seller = response.data ?? []
                }
            }
        }
    }
    
}
