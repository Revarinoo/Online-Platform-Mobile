//
//  Webservice.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/11/21.
//

import Foundation

class Webservice {
    
    func getCategories(completionHandler: @escaping (_ result: CategoryResponse?)-> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "categories")! as URL)
        
//        guard let url = URL(string: "\(HttpService.endpoint)categories") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        HttpService.shared.request(request as URLRequest, resultType: CategoryResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
}

struct CategoryResponse: Codable {
    let categories: [Category]?
    let message: String?
    let code: Int?
}
