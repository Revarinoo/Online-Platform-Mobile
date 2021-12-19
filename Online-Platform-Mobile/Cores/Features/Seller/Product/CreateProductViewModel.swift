//
//  CreateProductViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 13/12/21.
//

import Foundation
import Combine

class CreateProductViewModel: ObservableObject {
    
    @Published var packageName: String = ""
    @Published var packagePrice: String = ""
    @Published var packageCategory: String = "Photo"
    @Published var selectedIndex = 0
    @Published var revisionAmount = ""
    var highresolution: Bool = false
    var sourcefile: Bool = false
    var commercialuse: Bool = false
    var fullediting: Bool = false
    var lightediting: Bool = false
    var revision: Bool = false
    
    var listCategory = ["Photo", "Video", "USB(Photo/Video)", "Photo Album", "Photo Print", "Photo Frame"]
}
