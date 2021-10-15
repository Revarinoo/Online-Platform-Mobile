//
//  Online_Platform_MobileApp.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 09/10/21.
//

import SwiftUI

@main
struct Online_Platform_MobileApp: App {
    @StateObject var regVM = RegisterViewModel()
    var body: some Scene {
        WindowGroup {
            if regVM.isAuthenticated {
                HomeClient()
            }
            else {
                WelcomeView(registerVM: regVM)
            }
            
        }
    }
}
