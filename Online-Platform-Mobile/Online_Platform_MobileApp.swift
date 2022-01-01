//
//  Online_Platform_MobileApp.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 09/10/21.
//

import SwiftUI
import Firebase

@main
struct Online_Platform_MobileApp: App {
    
    @AppStorage("JWT", store: .standard) var token = ""
    @AppStorage("role", store: .standard) var role = ""
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if token == "" {
                OrderResultView()
            }
            else {
                if role == "Client" {
                    MyProductView()
//                    TabBar()
//                        .onAppear {
//                            UserHelper.shared.getUserData()
//                        }
                }
                else if role == "Seller" {
                    TabBarSeller(selection: 0)
                        .onAppear {
                            UserHelper.shared.getUserData()
                        }
                }
            }
        }
    }
}
