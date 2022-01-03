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
    
    func getOrderResult(orderId: Int, completionHandler: @escaping(_ result: [OrderResult], _ revisionAvailable: Bool) -> Void) {
        Alamofire.request(HttpService.endpoint + "order/result/\(orderId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let data = try? JSONDecoder().decode(OrderResultResponse.self, from: response.data!)
                completionHandler(data!.data, data!.revisionAvailable)
            }
    }
    
    func requestRevision(orderId: Int, reports: [Int], completionHandler: @escaping(_ code: Int)->Void) {
        let parameters: [String: Any] = [
            "order_id": orderId,
            "reports": reports
        ]
        
        Alamofire.request(HttpService.endpoint + "order/result/revision", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { data in
                if let response = data.response {
                    completionHandler(response.statusCode)
                }
            }
    }
}
