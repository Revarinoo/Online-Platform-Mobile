//
//  ReviewService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import Foundation
import Alamofire
import SwiftUI

struct ReviewRequest: Codable {
    let order_id: Int
    let comment: String
    let rating: Int
}

struct ReviewResponse: Codable {
    let code: Int
    let message: String
}

class ReviewService {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func addReview(orderId: Int, comment: String, rating: Int, completionHandler: @escaping(_ result: Int)-> Void) {
        let parameters: [String : Any] = [
            "order_id": orderId,
            "comment": comment,
            "rating": Int32(rating)
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Content-type": "application/json"
        ]

        Alamofire.request(HttpService.endpoint + "order/review", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(_): completionHandler(response.response!.statusCode)

                case .failure(let error):
                    print(error.localizedDescription)

                }

            }
    }
    
}
