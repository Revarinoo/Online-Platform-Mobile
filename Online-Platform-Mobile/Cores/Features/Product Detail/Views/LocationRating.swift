//
//  LocationRating.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 14/11/21.
//

import SwiftUI

struct LocationRating: View {
    var type: String
    var location: String?
    var rating: Double?
    var reviewCount: Int?
    var locationIcon = "location"
    var ratingIcon = "rating"
    
    var body: some View {
        HStack (spacing: 9) {
            Image(type == "Location" ? locationIcon : ratingIcon)
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
            VStack (alignment: .leading) {
                HStack {
                    Text(type == "Location" ? location! : "\(String(format: "%.1f", rating!))")
                        .font(.custom(ThemeFont.displayMedium, size: 15))
                        .foregroundColor(Color.theme.primary)
                    Text(type == "Rating" ? "(\(reviewCount!) reviews)" : "")
                        .font(.custom(ThemeFont.displayRegular, size: 12))
                        .foregroundColor(Color.theme.darkGrey)
                }
                Text(type)
                    .font(.custom(ThemeFont.displayRegular, size: 13.5))
                    .foregroundColor(Color.theme.darkGrey)
            }
        }
        .padding(EdgeInsets(top: 11, leading: 11, bottom: 11, trailing: 11))
        .frame(width: 165, height: 64, alignment: .leading)
        .background(Color.theme.primarywhite)
        .cornerRadius(10)
        .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
    }
}

struct LocationRating_Previews: PreviewProvider {
    static var previews: some View {
        LocationRating(type: "Location", location: "Jakarta")
            .previewLayout(.sizeThatFits)
    }
}
