//
//  PromoCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/01/22.
//

import SwiftUI

struct PromoCard: View {
    var body: some View {
        HStack {
            Text("%")
              .padding()
              .font(.system(size: 20))
              .foregroundColor(Color.white)
              .background(Color.theme.primary)
              .clipShape(Circle())
            VStack (alignment: .leading) {
                Text("5% Discount")
                    .font(.custom(ThemeFont.displayMedium, size: 18))
                    .padding(.bottom,0.5)
                HStack {
                    Image(systemName: "calendar")
                    Text("Exp: 21 January 2021")
                        .font(.caption)
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                }
                .foregroundColor(Color.gray)
                
            }
            .padding(.leading, 12)
            Spacer()
            Text("Use")
                .foregroundColor(Color.white)
                .frame(width: 80, height: 33)
                .background(Color.theme.primary)
                .cornerRadius(12)
        }
    }
}

struct PromoCard_Previews: PreviewProvider {
    static var previews: some View {
        PromoCard()
            .padding([.top, .bottom], 21)
            .padding([.leading, .trailing], 18)
            .frame(width: 358)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
    }
}
