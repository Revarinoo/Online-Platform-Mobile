//
//  OrderService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation
import SwiftUI



class OrderService {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func createOrder(orderRequest: PostOrderRequest ,completionHandler: @escaping(_ result: PostOrderResponse?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "order/create")! as URL)
        
        request.httpMethod = "post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(orderRequest)
        
        HttpService.shared.request(request as URLRequest, resultType: PostOrderResponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getAllOrder(completionHandler: @escaping(_ result: MyOrderResponse?) -> Void) {
        guard let url = URL(string: HttpService.endpoint + "order/all") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        HttpService.shared.request(request, resultType: MyOrderResponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getClientOrder(orderId: Int, completionHandler: @escaping(_ result: ClientOrderDetail?)->Void) {
        guard let url = URL(string: HttpService.endpoint + "client/order/detail/\(orderId)") else {
            return
        }
        HttpService.shared.request(URLRequest(url: url), resultType: ClientOrderDetail.self) { result in
            completionHandler(result)
        }
    }
}
