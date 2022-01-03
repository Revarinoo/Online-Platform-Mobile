//
//  OrderModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation

struct CreateOrder {
    var location: String = String("Location")
    var schedule_date: Date = Date()
    var schedule_time: Date = Date()
    var packages: [Int] = []
}

struct MyOrderResponse: Codable {
    let data: [MyOrderResponseDetail]
    let code: Int
    let message: String
}

struct MyOrderResponseDetail: Codable {
    let order_id: Int
    let photo: String
    let name: String
    let order_date: String
    let order_category: String
    let status: String
}

struct MyOrderModel: Identifiable {
    let id = UUID()
    let order_id: Int
    let photo: String
    let name: String
    let order_date: String
    let order_category: String
    let status: String
}

struct ComplainModel: Codable, Identifiable {
    let id: Int
    let client_name: String
    let complain_detail: String
    let result_link: String
}
