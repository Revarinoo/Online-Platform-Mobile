//
//  HomeClient.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import SwiftUI

struct HomeClient: View {
    
    var homeClientVM = HomeClientViewModel()
    
    var body: some View {
        NavigationView {
            Button {
                homeClientVM.signOut()
            } label: {
                Text("Sign Out")
            }

        }
        
    }
}

struct HomeClient_Previews: PreviewProvider {
    static var previews: some View {
        HomeClient()
    }
}
