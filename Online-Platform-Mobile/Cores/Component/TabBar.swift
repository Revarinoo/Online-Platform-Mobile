//
//  TabBar.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import SwiftUI

struct TabBar: View {
    @State var selection = 0
    @State var navTitle = ""
    
    var body: some View {
            TabView(selection: $selection) {
                NavigationView {
                    HomeClient()
                        .navigationTitle("Discover")
                }
                .tabItem {
                    Label("Discover", systemImage: "house")
                }
                .tag(0)
                NavigationView {
                    ProductView()
                        .navigationTitle("Product List")
                }
                .tabItem {
                    Label("Product", systemImage: "list.dash")
                }
                .tag(1)
                
                NavigationView {
                    MyOrderView()
                        .navigationTitle("My Order")
                }
                .tabItem {
                    Label("Order", systemImage: "newspaper")
                }
                .tag(2)
            }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.init(hex: "f4f4f4"))
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selection: 0)
    }
}
