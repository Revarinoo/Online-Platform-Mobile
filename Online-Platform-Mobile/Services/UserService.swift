//
//  UserService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 06/12/21.
//

import Foundation
import SwiftUI

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
}
