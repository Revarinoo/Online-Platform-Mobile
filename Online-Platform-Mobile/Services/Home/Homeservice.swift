//
//  Webservice.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/11/21.
//

import Foundation

class Homeservice {
    
    func getCategories(completionHandler: @escaping (_ result: CategoryResponse?)-> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "categories")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: CategoryResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
    func getRecommendedSeller(completionHandler: @escaping (_ result: RecommendedSellerResponse?)-> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "recommendation/seller")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: RecommendedSellerResponse.self) { response in
            _ = completionHandler(response)
        }
        
    }
    
}

struct CategoryResponse: Codable {
    let categories: [Category]?
    let message: String?
    let code: Int?
}

struct RecommendedSellerResponse: Codable {
    let data: [Seller]?
    let message: String?
    let code: Int?
}
