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
    static let shared = OrderService()
    
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
    
    func updatePaymentStatus(orderId: Int, status: String) {
        let parameters: [String : Any] = [
            "order_id": orderId,
            "payment_status": status
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
    
    func getAllOrderSeller(completionHandler: @escaping(_ result: MyOrderResponse?) -> Void) {
        guard let url = URL(string: HttpService.endpoint + "seller/order/all") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        HttpService.shared.request(request, resultType: MyOrderResponse.self) { result in
            completionHandler(result)
        }
    }
    
    func submitComplain(orderId: Int, message: String) {
        let parameters: [String: Any] = [
            "order_id": orderId,
            "complain_message": message
        ]
        updateRequest(parameters: parameters)
    }
    
    func getComplains(completionHandler: @escaping(_ result: [ComplainModel]?)->Void) {
        Alamofire.request(HttpService.endpoint + "order/complain", method: .get)
            .responseJSON { response in
                let data = try? JSONDecoder().decode([ComplainModel].self, from: response.data!)
                completionHandler(data)
            }
    }
    
    func updateComplain(orderId: Int, status: String, completionHandler: @escaping(_ code: Int)->Void) {
        let parameters: [String: Any] = [
            "order_id": orderId,
            "status": status
        ]
        
        Alamofire.request(HttpService.endpoint + "order/complain/update", method: .post, parameters: parameters)
            .responseJSON { response in
                if let response = response.response {
                    completionHandler(response.statusCode)
                }
            }
    }
    
    func getUserByOrder(orderId: Int, completionHandler: @escaping(_ userId: Int?) -> Void) {
        Alamofire.request(HttpService.endpoint + "order/\(orderId)/user", method: .get)
            .responseJSON { response in
                let data = try? JSONDecoder().decode(Int.self, from: response.data!)
                completionHandler(data)
            }
    }
    
    func getAllPromo(completionHandler: @escaping(_ result: [PromoModel]?) -> Void){
        Alamofire.request(HttpService.endpoint + "promo/all", method: .get)
            .responseJSON { response in
                if let data = response.data {
                    let result = try? JSONDecoder().decode([PromoModel].self, from: data)
                    completionHandler(result)
                }
            }
    }
}
