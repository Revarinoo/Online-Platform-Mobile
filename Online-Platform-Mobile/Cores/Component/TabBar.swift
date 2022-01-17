//
//  TabBar.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import SwiftUI

class TabBarViewModel: ObservableObject {
    static let shared = TabBarViewModel()
    @Published var selected = 0
    @Published var resetNavigationID = UUID()
}

struct TabBar: View {
    @StateObject private var tabBarVM = TabBarViewModel.shared
    @State var navTitle = ""
    
    var handler: Binding<Int> { Binding(
            get: { self.tabBarVM.selected },
            set: {
                self.tabBarVM.selected = $0
                self.tabBarVM.resetNavigationID = UUID()
            }
        )}
    
    var body: some View {
            TabView(selection: handler) {
                NavigationView {
                    HomeClient()
                        .navigationTitle("Discover")
                }
                .id(self.tabBarVM.resetNavigationID)
                .tabItem {
                    Label("Discover", systemImage: "house")
                }
                .tag(0)
                NavigationView {
                    ProductView()
                        .navigationTitle("Product List")
                }
                .id(self.tabBarVM.resetNavigationID)
                .tabItem {
                    Label("Product", systemImage: "camera")
                }
                .tag(1)
                
                NavigationView {
                    MyOrderView()
                        .navigationTitle("My Order")
                }
                .id(self.tabBarVM.resetNavigationID)
                .tabItem {
                    Label("Order", systemImage: "list.dash")
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

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
