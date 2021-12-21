//
//  OrderService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation
import SwiftUI
import Alamofire

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
    
    func updateOrderStatus(orderId: Int, status: String) {
        let parameters: [String : Any] = [
            "order_id": orderId,
            "status": status
        ]
        
        updateRequest(parameters: parameters)
    }
    
    private func updateRequest(parameters: [String : Any]) {
        Alamofire.request(HttpService.endpoint + "client/order/update" ,method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(_): break
                    
                case .failure(let error):
                    print(error)
                
                }
            }
    }
    
    func rescheduleOrder(orderId: Int, schedule_date: String) {
        let parameters: [String : Any] = [
            "order_id": orderId,
            "schedule_date": schedule_date
        ]
        
        updateRequest(parameters: parameters)
    }
}
