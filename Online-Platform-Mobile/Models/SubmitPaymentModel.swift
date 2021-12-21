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
