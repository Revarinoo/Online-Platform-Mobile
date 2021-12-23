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
                    OrderDetailSellerView(orderId: 2)
                        .navigationTitle("My Order")
                }
                .tabItem {
                    Label("Order", systemImage: "list.dash")
                }
                .tag(0)
                NavigationView {
                    ProfileView()
                        .navigationTitle("Product")
                }
                .tabItem {
                    Label("Product", systemImage: "archivebox")
                }
                .tag(1)
                
                NavigationView {
                    ProfileView()
                        .navigationTitle("Profile")
                }
                .tabItem {
                    Label("Order", systemImage: "person")
                }
                .tag(2)
            }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.init(hex: "f4f4f4"))
        }
    }
}

struct TabBarSeller_Previews: PreviewProvider {
    static var previews: some View {
        TabBarSeller()
    }
}
