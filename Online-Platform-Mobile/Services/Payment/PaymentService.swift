//
//  PaymentService.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import Foundation
import SwiftUI
import Alamofire

class PaymentService {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func payment(paymentRequest: PaymentRequest ,completionHandler: @escaping(_ result: PaymentResponse?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "payment/submit")! as URL)
        
        request.httpMethod = "post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(paymentRequest)
        
        HttpService.shared.request(request as URLRequest, resultType: PaymentResponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getTransactions(completionHandler: @escaping(_ result: [TransactionListModel]?)->Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Content-type": "application/json"
        ]
        Alamofire.request(HttpService.endpoint + "transactions/pending", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                let result = try? JSONDecoder().decode([TransactionListModel].self, from: response.data!)
                completionHandler(result)
            }
    }
}
