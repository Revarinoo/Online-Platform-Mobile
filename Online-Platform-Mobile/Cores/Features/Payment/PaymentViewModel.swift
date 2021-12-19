//
//  PaymentViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/12/21.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class PaymentViewModel: ObservableObject {
    
    private var paymentService = PaymentService()
    @Published var receiptImage: Image? = Image("")
    @Published var isShowingPhotoPicker = false
    @Published var isUploaded = true
    @Published var order_id = 0
    @Published var payment_Date = Date()
    @Published var bill_name =  ""
    @Published var imageReceipt: Data? = nil
    
//    func submitPayment() {
//        paymentService.payment(paymentRequest: PaymentRequest(order_id: self.order_id, transfer_receipt: self.imageReceipt ?? , payment_date: self.payment_Date, bill_name: self.bill_name)) { result in
//            if let result =  result {
//                if result.code == 201 {
//                    DispatchQueue.main.async {
//                        //
//                    }
//                }
//            }
//        }
//    }
//    func uploadReceipt(image: UIImage){
//        PhotoPicker(testImage: self.image)
//    }
}
