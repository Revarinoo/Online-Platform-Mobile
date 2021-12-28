//
//  ProfileViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: EditProfile = EditProfile()
    @Published var isFinishedUploading = false
    private let profileService = UserService()
    
    func editProfile() {
        profileService.editProfile(profileModel: self.profile) { result in
            if result == 200 {
                self.isFinishedUploading = true
            }
        }
    }
}
