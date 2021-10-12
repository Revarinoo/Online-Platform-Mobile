//
//  SecondaryButton.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/10/21.
//

import SwiftUI

struct SecondaryButton: View {
    
    let content: String
    let maxWidth: CGFloat?
    let action: () -> Void
    let textColor: Color
    
    var body: some View {
        Button(action: action, label: {
            Text(content)
                .foregroundColor(textColor)
                .frame(maxWidth: maxWidth)
                .padding()
                .padding(.horizontal,20)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(textColor, lineWidth: 1)
                )
        })
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(content: ("Sign Up"), maxWidth: 290, action: {}, textColor: Color.theme.primary)
            .previewLayout(.sizeThatFits)
    }
}
