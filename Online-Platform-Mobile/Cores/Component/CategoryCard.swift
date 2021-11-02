//
//  CategoryCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCard: View {
    
    var name: String
    var image: String
    
    var body: some View {
        WebImage(url: URL(string: image))
            .resizable()
            .frame(width: 129, height: 86)
            .cornerRadius(10)
            .scaledToFit()
            .brightness(-0.15)
            .overlay(
                Text("\(name)")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                ,alignment: .bottomLeading)
            .onAppear {
                print(name)
            }
    }
        
}

//struct CategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCard(category: Category.init(id: 1, name: "ayam", image: "ayam.png"))
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
