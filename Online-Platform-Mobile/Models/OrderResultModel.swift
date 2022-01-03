//
//  OrderResultModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 02/01/22.
//

import Foundation

struct OrderResultResponse: Codable {
    var data: [OrderResult] = []
    var revisionAvailable = false
    var message = String()
}

struct OrderResult: Codable, Identifiable {
    var id = Int()
    var file_path = String()
    var status = String()
}

struct OrderRevision: Identifiable {
    var id = Int()
    var file_path = String()
    var selected = false
}
