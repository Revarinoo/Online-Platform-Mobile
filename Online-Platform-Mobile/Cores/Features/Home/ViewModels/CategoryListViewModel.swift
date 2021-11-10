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
        if categories != nil {
            print(categories)
        } else {
            print("kosong")
        }
        
    }
    
    func fetchCategories() {
        print("hi fetch categories")
        Homeservice().getCategories { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.categories = response.categories ?? []
                    print("Response \(self.categories)")
                }
            }
        }
    }
    
}
