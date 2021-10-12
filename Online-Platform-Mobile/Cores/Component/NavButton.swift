//
//  NavButton.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/10/21.
//

import SwiftUI

struct NavButton<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    
    var body: some View {
        NavigationLink(destination: self.content) {
            Text("Find a Service")
                .frame(minWidth: 0, maxWidth: 300)
                .padding()
                .foregroundColor(.white)
                .background(Color.yellow)
                .cornerRadius(15)
                .font(.title3)
        }
    }
}

struct NavButton_Previews: PreviewProvider {
    static var previews: some View {
        NavButton<Content: Text("Hellow")>
    }
}
