//
//  HomeClient.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import SwiftUI

struct HomeClient: View {
    
    var homeClientVM = HomeClientViewModel()
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
    }
    
    var body: some View {
        NavigationView {
            
            CouponCard()
                .navigationBarTitle("Discover")
                .navigationBarItems(leading:
                                        Button(action: {
                    homeClientVM.signOut()
                }) {
                    Image(systemName: "xmark.circle.fill").imageScale(.large)
                        .foregroundColor(Color.theme.primary)
                }, trailing:
                    Button(action: {
                    print("Edit button pressed...")
                }) {
                    Image(systemName: "message").imageScale(.large)
                        .foregroundColor(Color.theme.primary)
                })
        }
        
    }
}

struct HomeClient_Previews: PreviewProvider {
    static var previews: some View {
        HomeClient()
    }
}
