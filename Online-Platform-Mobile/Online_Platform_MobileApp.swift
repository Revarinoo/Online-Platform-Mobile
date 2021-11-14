//
//  Online_Platform_MobileApp.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 09/10/21.
//

import SwiftUI

@main
struct Online_Platform_MobileApp: App {
    
    @AppStorage("JWT", store: .standard) var token = ""
    
    var body: some Scene {
        WindowGroup {
            if token == "" {
                WelcomeView()
            }
            else {
                ProductView()
            }
//            ProductDetailView()
        }
    }
}
