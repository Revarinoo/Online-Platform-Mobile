//
//  PaymentViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/12/21.
//

import Foundation
import SwiftUI
import Alamofire

class PaymentViewModel: ObservableObject {
    
    private var paymentService = PaymentService()
    @Published var isShowingPhotoPicker = false
    @Published var isUploaded = true
    @Published var imageReceipt: Data? = nil
    @Published var isFinishedUploading = false
    @AppStorage("JWT", store: .standard) var token = ""
    @Published var submitPaymentModel = SubmitPaymentModel()
    
    func submitPayment() {
        let defaultImage = UIImage(named: "defaultPhoto")!.jpegData(compressionQuality: 0.5)
        let transfer_receipt = submitPaymentModel.transfer_receipt.jpegData(compressionQuality: 0.5) ?? defaultImage
        
        let parameters =
        [
            "order_id": String(submitPaymentModel.order_id),
            "payment_date": submitPaymentModel.payment_date.serverFormattedDate(),
            "bill_name": submitPaymentModel.bill_name
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append((transfer_receipt ?? defaultImage) ?? Data(), withName: "transfer_receipt", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
            }
            
        }, to: HttpService.endpoint + "payment/submit", method: .post, headers: headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress { progress in
                    if progress.fractionCompleted == 1.0 {
                        
                    }
                }
                upload.responseData { response in
                    if let code = response.response?.statusCode {
                        if code >= 200 && code < 300 {
                            self.isFinishedUploading = true
                        }
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    

}
