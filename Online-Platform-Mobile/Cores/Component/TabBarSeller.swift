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
    @State var resetNavigationID = UUID()
    
    var handler: Binding<Int> { Binding(
            get: { self.selection },
            set: {
                self.selection = $0
                self.resetNavigationID = UUID()
            }
        )}
    
    var body: some View {
            TabView(selection: handler) {
                NavigationView {
                    OrderListView()
                        .navigationTitle("My Order")
                }
                .id(self.resetNavigationID)
                .tabItem {
                    Label("Order", systemImage: "list.dash")
                }
                .tag(0)
                NavigationView {
                    MyProductView()
                        .navigationTitle("My Product")
                }
                .id(self.resetNavigationID)
                .tabItem {
                    Label("Product", systemImage: "archivebox")
                }
                .tag(1)
                
                NavigationView {
                    ProfileView()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(2)
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
