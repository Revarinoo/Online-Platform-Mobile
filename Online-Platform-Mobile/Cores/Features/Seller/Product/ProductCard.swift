//
//  ProductCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCard: View {
    var product: SellerProductResponse
    
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 40, height: 40)
                WebImage(url: URL(string: product.icon))
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(Color.theme.primarywhite)
            }
            .padding(.leading)
            VStack(alignment: .leading) {
                Text(product.category)
                    .font(.custom(ThemeFont.displayMedium, size: 27))
                    .foregroundColor(Color.theme.primary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.theme.primary)
                .padding(.trailing)
        }
    }
}
