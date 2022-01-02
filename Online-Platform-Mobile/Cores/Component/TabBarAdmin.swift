//
//  TabBarAdmin.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 30/12/21.
//

import SwiftUI

struct TabBarAdmin: View {
    @State var selection = 0
    @State var navTitle = ""
    
    var body: some View {
            TabView(selection: $selection) {
                NavigationView {
                    TransactionListView()
                        .navigationTitle("Transaction List")
                }
                .tabItem {
                    Label("Transaction", systemImage: "newspaper")
                }
                .tag(0)
                
                NavigationView {
                    UserView()
                        .navigationTitle("User List")
                        .listStyle(PlainListStyle())
                }
                .tabItem {
                    Label("User", systemImage: "list.dash")
                }
                .tag(1)
                NavigationView {
                    CategoryListView()
                        .navigationTitle("Category List")
                }
                .tabItem {
                    Label("Category", systemImage: "archivebox")
                }
                .tag(2)
                
                NavigationView {
                    ProfileView()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Order", systemImage: "person")
                }
                .tag(3)
            }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.init(hex: "f4f4f4"))
        }
    }
}

struct TabBarAdmin_Previews: PreviewProvider {
    static var previews: some View {
        TabBarAdmin()
    }
}
