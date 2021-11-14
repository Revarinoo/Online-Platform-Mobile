//
//  ProductService.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/11/21.
//

import Foundation

class ProductService {
    func getSeller(categoryId: Int, completionHandler: @escaping (_ result: SellerResponse?)-> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "seller/\(categoryId)")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: SellerResponse.self) { response in
            _ = completionHandler(response)
        }
        
    }

}


struct SellerResponse: Codable {
    let data: [Seller]?
    let message: String?
    let code: Int?
}
