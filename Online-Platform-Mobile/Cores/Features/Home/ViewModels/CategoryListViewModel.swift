//
//  CategoryListViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/11/21.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    init() {
        fetchCategories()
        
    }
    
    func fetchCategories() {
        Homeservice().getCategories { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.categories = response.categories ?? []
                }
            }
        }
    }
    
}
