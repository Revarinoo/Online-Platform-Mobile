//
//  HomeClientViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import Foundation
import SwiftUI

class HomeClientViewModel: ObservableObject {
    @AppStorage("JWT", store: .standard) var token = ""
    @Published var categories: [Category] = []
    @Published var recseller: [Seller] = []
    @Published var seller: [Seller] = []
    @Published var selectedCategory:Int = 0
    
    
    init() {
        fetchRecommendedSeller()
        fetchSeller(catId: selectedCategory)
        
    }
    
    func signOut() {
        token = ""
    }
    
    func fetchSeller(catId: Int) {
        print("hi seller")
        ProductService().getSeller(categoryId: catId) { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.seller = response.data ?? []
                    print("ini Response \(self.seller)")
                }
            }
        }
    }
    
    func fetchRecommendedSeller() {
        print("hi rec seller")
        Homeservice().getRecommendedSeller { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.recseller = response.data ?? []
                    print("ini Response \(self.seller)")
                }
            }
        }
    }
}
