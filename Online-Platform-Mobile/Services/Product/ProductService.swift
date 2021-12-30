//
//  ProductService.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/11/21.
//

import Foundation
import Alamofire
import SwiftUI

class ProductService {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func getSeller(categoryId: Int, completionHandler: @escaping (_ result: SellerResponse?)-> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "seller/\(categoryId)")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: SellerResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
    func createProduct(productModel: CreateProductModel, completionHandler: @escaping(_ result: Int, _ id: Int) -> Void) {
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
                        let data = response.data
                        let responses = try? JSONDecoder().decode(CreateProductResponse.self, from: data!)
                        completionHandler(code, responses?.product_id ?? 0)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createPackage(productId: Int, package: CreatePackageModel, completionHandler: @escaping(_ result: Int)->Void) {
        let parameters: [String: Any] = [
            "product_id": productId,
            "price": Int(package.price) ?? 0,
            "revision": package.revision,
            "quantity": package.quantity,
            "type": package.type,
            "high_resolution": package.highResolution ? 1 : 0,
            "source_file": package.sourceFile ? 1 : 0,
            "commercial_use": package.commercial ? 1 : 0,
            "light_editing": package.editing ? 1 : 0
        ]
        
        Alamofire.request(HttpService.endpoint + "package/create", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                completionHandler(response.response!.statusCode)
            }
    }
    
    func getSellerProducts(completionHandler: @escaping(_ result: SellerProduct?)-> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Content-type": "application/json"
        ]
        Alamofire.request(HttpService.endpoint + "products/seller", method: .get, headers: headers)
            .responseJSON { response in
                let data = response.data
                let result = try? JSONDecoder().decode(SellerProduct.self, from: data!)
                completionHandler(result)
            }
    }
    
    func getSellerProductDetail(productId: Int, completionHandler: @escaping(_ result: SellerProductDetail?)-> Void) {
        Alamofire.request(HttpService.endpoint + "seller/product/\(productId)", method: .get)
            .responseJSON { response in
                let result = try? JSONDecoder().decode(SellerProductDetail.self, from: response.data!)
                completionHandler(result)
            }
    }
    
    func updateProduct(productId: Int, productModel: CreateProductModel, completionHandler: @escaping(_ statusCode: Int) -> Void) {
        var portfolios : [Data] = []
        for portfolio in productModel.portfolios {
            let imageData = portfolio.pngData()!
            portfolios.append(imageData)
        }
        
        let parameters = [
            "product_id": String(productId),
            "category": productModel.category,
            "description": productModel.description
        ]
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (index, value) in portfolios.enumerated() {
                multipartFormData.append(value, withName: "portfolios[\(index)]", fileName: "\(index).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: HttpService.endpoint + "products/update", method: .post) { result in
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
    
    func removeProduct(productId: Int, completionHandler: @escaping(_ code: Int)->Void) {
        Alamofire.request(HttpService.endpoint + "product/delete/\(productId)", method: .delete)
            .responseJSON { data in
                if let code = data.response?.statusCode {
                    completionHandler(code)
                }
            }
    }
    
    func getAllSellerProduct(userId: Int, completionHandler: @escaping(_ result: SellerProduct?)->Void) {
        Alamofire.request(HttpService.endpoint + "seller/\(userId)/products", method: .get)
            .responseJSON { response in
                let result = try? JSONDecoder().decode(SellerProduct.self, from: response.data!)
                completionHandler(result)
            }
    }
}



