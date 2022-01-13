//
//  PortfolioService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/01/22.
//

import Foundation
import Alamofire

class PortfolioService {
    func getPortfoliosByProductId(productId: Int, completionHandler: @escaping(_ result: [PortfoliosModel]?)->Void) {
        Alamofire.request(HttpService.endpoint + "seller/\(productId)/portfolios", method: .get)
            .responseJSON { response in
                let result = try? JSONDecoder().decode([PortfoliosModel].self, from: response.data!)
                completionHandler(result)
            }
    }
    
    func updatePortfoliosByProductId(productId: Int, completionHandler: @escaping(_ code: Int)->Void) {
        Alamofire.request(HttpService.endpoint + "portfolios/\(productId)/update", method: .put)
            .responseJSON { response in
                if let responses = response.response {
                    completionHandler(responses.statusCode)
                }
            }
    }
}
