//
//  ProductDetailService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import Foundation

class ProductDetailService {
    
    func getProductDetail(productId: Int, completionHandler: @escaping(_ result: ProductDetailResponse?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: HttpService.endpoint + "product/detail/\(productId)")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: ProductDetailResponse.self) { result in
            completionHandler(result)
        }
    }
}
