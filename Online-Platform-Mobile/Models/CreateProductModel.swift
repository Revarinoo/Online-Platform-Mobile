//
//  CreateProductModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 28/12/21.
//

import Foundation
import SwiftUI

struct CreateProductModel {
    var category = String()
    var description = String()
    var portfolios: [UIImage] = []
}

struct CreatePackageModel: Identifiable {
    var id = UUID()
    var type = "Photo"
    var price = String()
    var quantity = Int()
    var highResolution = Bool()
    var sourceFile = Bool()
    var commercial = Bool()
    var editing = Bool()
    var revision = Int()
    
    mutating func reset() {
         id = UUID()
         type = String()
         price = String()
         quantity = Int()
         highResolution = Bool()
         sourceFile = Bool()
         commercial = Bool()
         editing = Bool()
         revision = Int()
    }
}
