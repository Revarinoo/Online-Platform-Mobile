//
//  TabBar.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import SwiftUI

struct TabBar: View {
    @State var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                
                ZStack {
                    HomeClient()
                }
                .tabItem {
                    Label("Discover", systemImage: "house")
                }
                .tag(0)
                ZStack {
                    ProductView()
                }
                .tabItem {
                    Label("Product", systemImage: "list.dash")
                }
                .tag(1)
            }
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
