//
//  CategoryViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 31/12/21.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    private let categoryService = CategoryService()
    @Published var categories: [Category] = []
    @Published var successfullyCreated = false
    
    func getCategories() {
        Homeservice().getCategories { result in
            if let result = result {
                if let data = result.categories {
                    DispatchQueue.main.async {
                        self.categories = data
                    }
                }
            }
        }
    }
    
    func removeCategory(id: Int) {
        categoryService.removeCategory(categoryId: id) { code in
            if code == 200 {
                self.getCategories()
            }
        }
    }
    
    func createCategory(categoryName: String, icon: UIImage) {
        categoryService.createCategory(name: categoryName, icon: icon) { code in
            if code == 200 {
                self.successfullyCreated = true
                self.getCategories()
            }
        }
    }
}
