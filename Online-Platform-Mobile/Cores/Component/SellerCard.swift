//
//  SellerCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SellerCard: View {
    
    var name: String
    var category: [String]
    //var sellertype: String
    var image: String
    var rate: Double
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(10)
                .clipped() // Equal to clipsToBounds = true
            VStack (alignment: .leading) {
                Text(name)
                    .fontWeight(.medium)
                HStack{
                    if (category.count != 0) {
                        ForEach(0 ..< category.count) { value in
                            Text(category[value])
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    } else {
                        Text("-")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                RatingCard(rate: rate)
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
        SellerCard(name: "Tian", category: ["String","hei"], image: "Wedding", rate: 2.0)
            .cornerRadius(10)
            .padding()
            .previewLayout(.sizeThatFits)
        
    }
}
