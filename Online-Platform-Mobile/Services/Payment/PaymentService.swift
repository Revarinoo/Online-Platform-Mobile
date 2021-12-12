//
//  PaymentService.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import Foundation
import SwiftUI

struct PaymentRequest: Encodable {
    let order_id: Int
//    let transfer_receipt: Image
    let payment_date: Date
    let bill_name: String
}

struct PaymentResponse: Codable {
    let code: Int
    let message: String
}
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
}
