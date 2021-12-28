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

struct CreatePackageModel {
    var type = String()
    var price = Double()
    var quantity = Int()
    var highResolution = Bool()
    var sourceFile = Bool()
    var commercial = Bool()
    var editing = Bool()
    var revision = Int()
}
