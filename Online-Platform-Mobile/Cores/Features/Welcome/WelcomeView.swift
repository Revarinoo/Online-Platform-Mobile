//
//  WelcomeView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/10/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("welcomepage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("FOTOIN")
                        .foregroundColor(.white)
                    Text("FOTOIN")
                        .foregroundColor(.white)
                }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
