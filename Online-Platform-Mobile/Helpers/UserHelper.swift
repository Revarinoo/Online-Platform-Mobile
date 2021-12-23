//
//  Helper.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 12/10/21.
//

import Foundation

class UserHelper: ObservableObject {
    static let shared = UserHelper()
    @Published var user : UserProfile = UserProfile(id: 0, name: "", email: "", phone_number: "", photo: "")
    private let service = UserService()
    
    func getUserData() {
        service.getUserProfile { result in
            if let response = result {
                DispatchQueue.main.async {
                    self.user = UserProfile(id: response.id, name: response.name, email: response.email, phone_number: response.phone_number, photo: response.photo)
                }
            }
        }
    }
}
