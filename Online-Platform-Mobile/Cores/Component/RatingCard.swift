//
//  RatingCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI

struct RatingCard: View {
    
    var rate: Float = 4.0
    
    var body: some View {
        Label(String(rate), systemImage: "star.fill")
            .font(.caption)
            .foregroundColor(Color.theme.secpurple)
            .padding(.vertical,5)
            .padding(.horizontal,10)
            .frame(minWidth: 47, minHeight: 20)
            .background(Color.theme.secondary)
            .cornerRadius(10)
    }
}

struct RatingCard_Previews: PreviewProvider {
    static var previews: some View {
        RatingCard()
            .previewLayout(.sizeThatFits)
    }
}
