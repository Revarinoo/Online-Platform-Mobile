//
//  OrderService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation
import SwiftUI

struct PostOrderResponse: Codable {
    let code: Int
    let message: String
    let order_id: Int
}

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
}
