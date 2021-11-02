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
        Webservice().getCategories { response in
            if let response = response {
                self.categories = response.categories ?? []
            }
        }
    }
    
}

//class CategoryViewModel {
//
//    var category: Category
//
//    init(category: Category){
//        self.category = category
//    }
//
//    var id: Int {
//        return self.category.id
//    }
//
//    var name: String {
//        return self.category.name
//    }
//
//    var image: String {
//        return self.category.image
//    }
//}
