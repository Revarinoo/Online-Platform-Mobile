//
//  PrimaryButton.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/10/21.
//

import SwiftUI

struct PrimaryButton: View {
    
    let content: String
    let maxWidth: CGFloat?
    let action: () -> Void
    let btnColor: Color
    let textColor: Color
    
    var body: some View {
        Button(action: action, label: {
            Text(content)
                .foregroundColor(textColor)
                .frame(width: (maxWidth != nil) ? maxWidth : nil)
                .padding()
                .padding(.horizontal,20)
                .background(btnColor)
                .cornerRadius(15)
        })
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(content: ("Log In"), maxWidth: 290, action: {}, btnColor: Color.theme.primary, textColor: Color.theme.primarywhite)
            .previewLayout(.sizeThatFits)
    }
}
