//
//  OrderDetailService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import Foundation
import Alamofire

struct OrderDetailSeller: Codable {
    let schedule_date: String
    let schedule_time: String
    let order_location: String
    let package: [PackageResponse]
}

struct PackageResponse: Codable {
    let type: String
    let quantity: Int
    let price: Double
}

class OrderDetailService {
    
    func getSellerOrderDetail(orderId: Int) {
        let request = Alamofire.request(HttpService.endpoint + "seller/order/detail/\(orderId)")
        request.responseJSON { response in
            let data = response.data
            let responses = try? JSONDecoder().decode(OrderDetailSeller.self, from: data!)
            print(responses?.order_location)
        }
    }
}
