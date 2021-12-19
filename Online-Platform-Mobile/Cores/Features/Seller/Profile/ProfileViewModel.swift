//
//  ProfileViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 15/12/21.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var seller: User = User(name: "Muhammad", email: "Muh.ardie", type_role: "user", updated_at: nil, created_at: nil, id: 2)
}
