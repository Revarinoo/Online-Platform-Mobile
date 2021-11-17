//
//  CategoryIcon.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 06/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryIcon: View {
    
    var image: String
    var name: String
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 40, height: 40)
                WebImage(url: URL(string: image))
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(Color.theme.primarywhite)
            }
            Text(name)
                .fontWeight(.medium)
                .font(.caption)
                .foregroundColor(Color.theme.primary)
        }
        .frame(minWidth: 63, maxHeight: 60)
        .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
    }
}

struct CategoryIcon_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIcon(image: "❤️", name: "Category")
            .previewLayout(.sizeThatFits)

    }
}
