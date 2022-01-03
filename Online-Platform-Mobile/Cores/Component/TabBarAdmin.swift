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
                    ComplainListView()
                        .navigationTitle("Complain List")
                }
                .tabItem {
                    Label("Complain", systemImage: "person.crop.circle.badge.exclamationmark")
                }
                .tag(1)
                
                NavigationView {
                    UserView()
                        .navigationTitle("User List")
                        .listStyle(PlainListStyle())
                }
                .tabItem {
                    Label("User", systemImage: "person")
                }
                .tag(2)
                NavigationView {
                    CategoryListView()
                        .navigationTitle("Category List")
                }
                .tabItem {
                    Label("Category", systemImage: "list.dash")
                }
                .tag(3)
                
                NavigationView {
                    ProfileView()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
                .tag(4)
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
