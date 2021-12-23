//
//  OrderDetailService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import Foundation
import Alamofire

class OrderDetailService {
    
    func getSellerOrderDetail(orderId: Int, completionHandler: @escaping(_ response: OrderDetailSeller?)->Void) {
        let request = Alamofire.request(HttpService.endpoint + "seller/order/detail/\(orderId)")
        request.responseJSON { response in
            let data = response.data
            let responses = try? JSONDecoder().decode(OrderDetailSeller.self, from: data!)
            completionHandler(responses)
        }
    }
}
