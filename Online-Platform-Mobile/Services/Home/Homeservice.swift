//
//  Webservice.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/11/21.
//

import Foundation
import SwiftUI

class Homeservice {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func getCategories(completionHandler: @escaping (_ result: CategoryResponse?)-> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "categories")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: CategoryResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
    func getRecommendedSeller(completionHandler: @escaping (_ result: RecommendedSellerResponse?)-> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "product/recommendation")! as URL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        HttpService.shared.request(request as URLRequest, resultType: RecommendedSellerResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
}

