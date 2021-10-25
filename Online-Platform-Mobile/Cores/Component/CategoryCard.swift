//
//  CategoryCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI

struct CategoryCard: View {
    
    var body: some View {
        Image("wedding")
            .resizable()
            .frame(width: 129, height: 86)
            .cornerRadius(10)
            .scaledToFit()
            .brightness(-0.15)
            .overlay(
                VStack(alignment: .leading){
                    Text("Wedding")
                        .fontWeight(.semibold)
                    Text("from IDR 300K")
                        .fontWeight(.medium)
                }
                .font(.caption)
                .foregroundColor(.white)
                    .padding(8)
                ,alignment: .bottomLeading)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
