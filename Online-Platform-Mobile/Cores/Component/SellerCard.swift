//
//  SellerCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI

struct SellerCard: View {
    
    var name: String = "Daniel Alex"
    var category: String = "Graduation, Wedding"
    
    var body: some View {
        HStack {
            Image("sayang")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(10)
                .clipped() // Equal to clipsToBounds = true
            VStack (alignment: .leading) {
                Text(name)
                    .fontWeight(.medium)
                Text(category)
                    .font(.caption)
                    .foregroundColor(.gray)
                RatingCard()
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 28))
                .foregroundColor(Color.theme.secpurple)
        }
        .padding()
        .background(Color.theme.primarywhite)
    }
}

struct SellerCard_Previews: PreviewProvider {
    static var previews: some View {
        SellerCard()
            .cornerRadius(10)
            .padding()
            .previewLayout(.sizeThatFits)
            
    }
}
