//
//  CategoryService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 31/12/21.
//

import Foundation
import Alamofire
import SwiftUI

class CategoryService {
    
    func removeCategory(categoryId: Int, completionHandler: @escaping(_ code: Int)->Void) {
        Alamofire.request(HttpService.endpoint + "category/remove/\(categoryId)", method: .delete)
            .responseJSON { response in
                if let response = response.response {
                    completionHandler(response.statusCode)
                }
            }
    }
    
    func createCategory(name: String, icon: UIImage, completionHandler: @escaping(_ code: Int)->Void) {
        let photo = icon.jpegData(compressionQuality: 0.8)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(photo, withName: "icon", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
        }, to: HttpService.endpoint + "categories/create", method: .post) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData { response in
                    if let code = response.response?.statusCode {
                        if code == 200 {
                            completionHandler(code)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
