//
//  ProfileViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profile: EditProfile = EditProfile()
    @Published var isFinishedUploading = false
    private let profileService = UserService()
    @Published var redBanner = false
    @Published var failedMessage = ""
    @ObservedObject private var profileVM = UserHelper.shared
    
    func fetchData() {
        var imageData = UIImage()
        if let data = try? Data(contentsOf: URL(string: profileVM.user.photo)!) {
            imageData = UIImage(data: data)!
        }
        self.profile = EditProfile(name: profileVM.user.name, email: profileVM.user.email, phoneNumber: profileVM.user.phone_number, password: "", photo: imageData)
    }
    
    func editProfile() {
        if profile.password.isEmpty || profile.name.isEmpty || profile.email.isEmpty || profile.phoneNumber.isEmpty {
            redBanner = true
            return
        }
        if !isValidEmail(value: profile.email) {
            self.failedMessage = "Email format is incorrect!"
            redBanner = true
            return
        }
        if profile.password.count < 6 {
            self.failedMessage = "Password must have minimum 6 character!"
            redBanner = true
            return
        }
        profileService.editProfile(profileModel: self.profile) { result in
            if result == 200 {
                self.isFinishedUploading = true
            }
        }
    }
    
    private func isValidEmail(value: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
}
