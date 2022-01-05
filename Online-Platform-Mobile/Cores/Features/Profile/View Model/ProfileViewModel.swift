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
    @ObservedObject private var profileVM = UserHelper.shared
    
    func fetchData() {
        var imageData = UIImage()
        if let data = try? Data(contentsOf: URL(string: profileVM.user.photo)!) {
            imageData = UIImage(data: data)!
        }
        self.profile = EditProfile(name: profileVM.user.name, email: profileVM.user.email, phoneNumber: profileVM.user.phone_number, password: "", photo: imageData)
    }
    
    func editProfile() {
        profileService.editProfile(profileModel: self.profile) { result in
            if result == 200 {
                self.isFinishedUploading = true
            }
        }
    }
}
