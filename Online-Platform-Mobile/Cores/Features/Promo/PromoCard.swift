//
//  PromoCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/01/22.
//

import SwiftUI

struct PromoCard: View {
    var promo: PromoModel
    @Binding var promo_id: Int
    @Binding var disc: Int
    @State private var isClicked = false
    
    var body: some View {
        HStack {
            Text("%")
              .padding()
              .font(.system(size: 20))
              .foregroundColor(Color.white)
              .background(Color.theme.primary)
              .clipShape(Circle())
            VStack (alignment: .leading, spacing: 2) {
                Text(promo.code)
                    .font(.custom(ThemeFont.displayMedium, size: 18))
                    .foregroundColor(Color.theme.primary)
                Text("Disc \(promo.percent_discount)%, up to \(Int(promo.maximum_discount).setPriceFormat())")
                    .font(.custom(ThemeFont.displayRegular, size: 15))
                    .foregroundColor(Color.theme.darkGrey)
                Text("Min. \(Int(promo.minimum_order).setPriceFormat())")
                    .font(.custom(ThemeFont.displayRegular, size: 15))
                    .foregroundColor(Color.theme.darkGrey)
            }
            .padding(.leading, 12)
            Spacer()
            Button {
                promo_id = promo.id
                disc = promo.percent_discount
                isClicked.toggle()
            } label: {
                Text("Use")
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 33)
                    .background(isClicked ? Color.theme.darkGrey : Color.theme.primary)
                    .cornerRadius(12)
            }

        }
    }
}

