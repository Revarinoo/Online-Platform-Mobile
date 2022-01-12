//
//  OrderDetailModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 23/12/21.
//

import Foundation

struct OrderDetailSeller: Codable {
    var order_status: String = String()
    var schedule_date: String = String()
    var schedule_time: String = String()
    var order_location: String = String()
    var package: [PackageResponse] = []
    var client_name: String = String()
    var shipping_address: String = String()
    var payment_status: String = String()
}

struct PackageResponse: Codable, Identifiable {
    let id: Int
    let type: String
    let quantity: Int
    let price: Double
}
