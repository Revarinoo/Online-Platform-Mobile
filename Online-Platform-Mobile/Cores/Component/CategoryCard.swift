//
//  CategoryCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI

struct CategoryCard: View {
    
    @Binding var category: Category
//     var name: String
//     var image: String
    
    var body: some View {
        Image("\(category.image)")
            .resizable()
            .frame(width: 129, height: 86)
            .cornerRadius(10)
            .scaledToFit()
            .brightness(-0.15)
            .overlay(
                Text("\(category.name)")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                ,alignment: .bottomLeading)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: .constant(Category(id: 1, name: "Wedding", image: "Wedding")))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
