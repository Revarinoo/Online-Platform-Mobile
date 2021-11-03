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
    
    
    init() {
        fetchRecommendedSeller()
        if recseller != nil {
            print(recseller)
        } else {
            print("ga ada recommend seller")
        }
        
    }
    
    func signOut() {
        token = ""
    }
    
    func fetchRecommendedSeller() {
        print("hi rec seller")
        Homeservice().getRecommendedSeller { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.recseller = response.data ?? []
                    print("Response \(self.categories)")
                }
            }
        }
    }
}
