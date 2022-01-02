//
//  ClientOrderDetailModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 21/12/21.
//

import Foundation

struct ClientOrderDetail: Codable {
    var order_status: String = String()
    var order_date: String = String()
    var order_time: String = String()
    var order_location: String = String()
    var shipping_courier: String = String()
    var tracking_number: String = String()
    var result_link: String = String()
    var already_reviewed: Int = Int()
    var status: String = String()
    var code: Int = Int()
}
