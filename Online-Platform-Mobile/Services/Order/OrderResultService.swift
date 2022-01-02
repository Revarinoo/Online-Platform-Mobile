//
//  OrderResultService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 02/01/22.
//

import Foundation
import Alamofire
import SwiftUI

class OrderResultService {
    
    func submitOrderResult(orderId: Int, result: String, images: [UIImage], completionHandler: @escaping(_ code: Int) -> Void) {
        let parameters = [
            "order_id": String(orderId),
            "result_link": result
        ]
        var imagesData: [Data] = []
        for image in images {
            let data = image.jpegData(compressionQuality: 0.3)!
            imagesData.append(data)
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if images.count != 0 {
                for (index, value) in imagesData.enumerated() {
                    multipartFormData.append(value, withName: "images[\(index)]", fileName: "\(index).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: HttpService.endpoint + "order/report", method: .post) { result in
            switch result {
            case .success(let upload, _, _) :
                upload.responseData { response in
                    if let response = response.response {
                        completionHandler(response.statusCode)
                    }
                }
                
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
