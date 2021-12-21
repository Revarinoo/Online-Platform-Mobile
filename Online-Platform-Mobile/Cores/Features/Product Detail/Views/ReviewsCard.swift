//
//  ReviewsCard.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/11/21.
//

import SwiftUI

struct ReviewsCard: View {
    var review: ReviewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
                Text("\"\(review.comment)\"")
                    .font(.custom(ThemeFont.displayRegular, size: 12))
                    .foregroundColor(Color.theme.primary)
                    .padding(.top, 16)
                Spacer()
                HStack {
                    Spacer()
                    Text(review.name)
                        .font(.custom(ThemeFont.displayRegular, size: 12))
                        .foregroundColor(Color.theme.darkGrey)
                }
            }
        .frame(width: 210, height: 120)
            .padding(EdgeInsets(top: 8, leading: 11, bottom: 4, trailing: 11))
            .background(Color.theme.primarywhite)
            .cornerRadius(10)
            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
    }
}

struct ReviewsCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsCard(review: ReviewModel(name: "Johnny Andrey", comment: "Highly reccomend this videographer for our wedding party! The result is really amazing with very affordable price. Worth every penny for this fantastic service"))
            .previewLayout(.sizeThatFits)
    }
}
