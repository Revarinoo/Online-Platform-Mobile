//
//  UserService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 06/12/21.
//

import Foundation
import SwiftUI
import Alamofire

class UserService {
    @AppStorage("JWT", store: .standard) var token = ""
    func getUserProfile(completionHandler:@escaping(_ result: UserProfile?)->Void){
        let request = NSMutableURLRequest(url: NSURL(string:  HttpService.endpoint + "user")! as URL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        HttpService.shared.request(request as URLRequest, resultType: UserProfile.self) { response in
               completionHandler(response)
           }
    }
    
    func getSpecificUserProfile(userId: Int, completionHandler:@escaping(_ result: UserProfile?)->Void){
        let request = NSMutableURLRequest(url: NSURL(string:  HttpService.endpoint + "user/\(userId)")! as URL)
        HttpService.shared.request(request as URLRequest, resultType: UserProfile.self) { response in
               completionHandler(response)
           }
    }
    
    func editProfile(profileModel: EditProfile, completionHandler: @escaping(_ result: Int)->Void) {
        let defaultImage = UIImage(named: "defaultPhoto")!.jpegData(compressionQuality: 0.3)
        let photo = profileModel.photo.jpegData(compressionQuality: 0.3) ?? defaultImage
        let parameters: [String: String] = [
            "name" : profileModel.name,
            "email" : profileModel.email,
            "password" : profileModel.password,
            "phone_number": profileModel.phoneNumber
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if profileModel.photo != UIImage() {
                multipartFormData.append((photo ?? defaultImage) ?? Data(), withName: "photo", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key )
            }
            
        }, to: HttpService.endpoint + "profile/edit", method: .post, headers: headers) { result in
            switch result {
            case .success(let upload, _, _) :
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
    
    func getAllUser(completionHandler: @escaping(_ result: [User]?)->Void) {
        Alamofire.request(HttpService.endpoint + "show/users", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = try? JSONDecoder().decode([User].self, from: response.data!)
                completionHandler(result)
            }
    }
    
    func removeUser(userId: Int, completionHandler: @escaping(_ code: Int)->Void) {
        Alamofire.request(HttpService.endpoint + "user/delete/\(userId)", method: .delete)
            .responseJSON { data in
                if let response = data.response {
                    completionHandler(response.statusCode)
                }
            }
    }
}
