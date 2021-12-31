//
//  SubmitPaymentModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import Foundation
import SwiftUI

struct SubmitPaymentModel {
    var order_id: Int = Int()
    var transfer_receipt:  UIImage = UIImage()
    var payment_date: Date = Date()
    var bill_name: String = String()
}

struct TransactionListModel: Codable, Identifiable {
    var id = Int()
    var user = String()
    var payment_date = String()
    var bill_name = String()
    var transfer_receipt = String()
    var total_payment = Double()
}

struct PaymentRequest: Encodable {
    let order_id: Int
    let transfer_receipt: Data
    let payment_date: Date
    let bill_name: String
}

struct PaymentResponse: Codable {
    let code: Int
    let message: String
}
