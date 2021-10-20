//
//  HomeClientViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import Foundation
import SwiftUI

class HomeClientViewModel {
    @AppStorage("JWT", store: .standard) var token = ""
    
    func signOut() {
        token = ""
    }
}
