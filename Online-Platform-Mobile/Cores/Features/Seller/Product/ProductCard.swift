//
//  ProductCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCard: View {
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 40, height: 40)
                WebImage(url: URL(string: "wedding"))
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(Color.theme.primarywhite)
            }
            .padding(.leading)
            VStack(alignment: .leading) {
                Text("Wedding")
                    .foregroundColor(Color.theme.primary)
                    .fontWeight(.semibold)
                Text("Photograpghy")
                        .foregroundColor(Color.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.theme.primary)
                .padding(.trailing)
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard()
            .frame(width: 358, height: 95)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
    }
}
