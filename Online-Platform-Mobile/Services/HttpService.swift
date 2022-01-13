//
//  HttpService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/10/21.
//

import Foundation

final class HttpService {
    static let shared = HttpService()
    static let endpoint = "http://34.124.239.196/online-platform-backend/public/api/"
    private init(){}

    func request<T:Decodable>(_ request: URLRequest, resultType:T.Type, completionHandler:@escaping(_ result: T?)-> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error == nil && data != nil) {
                let responses = try? JSONDecoder().decode(resultType.self, from: data!)
                completionHandler(responses)
            }
            if (error != nil) {
                print("error")
            }
        }.resume()
    }
}
