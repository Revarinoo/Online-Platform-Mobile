//
//  OrderResultViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 30/12/21.
//

import Foundation

class OrderResultViewModel: ObservableObject {
    
    @Published var selectedPhoto: [Photo] = []
    @Published var preview: Bool = false
    @Published var imagepreview = ""
    
    func removeSelected(selected: Photo) {
        
        selectedPhoto.removeAll(where: {$0.image == selected.image})
        
    }
    
}
