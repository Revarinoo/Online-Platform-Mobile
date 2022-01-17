//
//  TabBarSeller.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI

struct TabBarSeller: View {
    
    @State var selection = 0
    @State var navTitle = ""
    
    var body: some View {
            TabView(selection: $selection) {
                NavigationView {
                    OrderListView()
                        .navigationTitle("My Order")
                }
                .tabItem {
                    Label("Order", systemImage: "list.dash")
                }
                .tag(0)
                NavigationView {
                    MyProductView()
                        .navigationTitle("My Product")
                }
                .tabItem {
                    Label("Product", systemImage: "archivebox")
                }
                .tag(1)
                
                NavigationView {
                    ChatList()
                }
                .tabItem {
                    Label("Chat", systemImage: "message")
                }
                .tag(2)
                
                NavigationView {
                    ProfileView()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(3)
            }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.init(hex: "f4f4f4"))
            UserHelper.shared.getUserData()
        }
    }
}

struct TabBarSeller_Previews: PreviewProvider {
    static var previews: some View {
        TabBarSeller()
    }
}
