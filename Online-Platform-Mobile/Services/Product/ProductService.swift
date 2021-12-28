//
//  ProductService.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/11/21.
//

import Foundation
import Alamofire
import SwiftUI

struct SellerResponse: Codable {
    let data: [Seller]?
    let message: String?
    let code: Int?
}

class ProductService {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func getSeller(categoryId: Int, completionHandler: @escaping (_ result: SellerResponse?)-> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "seller/\(categoryId)")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: SellerResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
    func createProduct(productModel: CreateProductModel, completionHandler: @escaping(_ result: Int) -> Void) {
        var portfolios : [Data] = []
        for portfolio in productModel.portfolios {
            let imageData = portfolio.pngData()!
            portfolios.append(imageData)
        }
        
        let parameters = [
            "category": productModel.category,
            "description": productModel.description
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (index, value) in portfolios.enumerated() {
                multipartFormData.append(value, withName: "portfolios[\(index)]", fileName: "\(index).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: HttpService.endpoint + "product/create", method: .post, headers: headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData { response in
                    if let code = response.response?.statusCode {
                        completionHandler(code)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



