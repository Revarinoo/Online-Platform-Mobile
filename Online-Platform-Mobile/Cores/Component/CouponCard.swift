//
//  CouponCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 25/10/21.
//

import SwiftUI

struct CouponCard: View {
    
    
    var headcoupon:String = "Welcoming Offer"
    var detailcoupon:String = "10% off your first order with phorographer"
    
    var body: some View {
        
        HStack (spacing: 30){
            VStack (alignment: .leading, spacing: 10) {
                HStack (spacing: 3){
                    Text(headcoupon)
                        .font(.callout)
                    Image("bintang")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(detailcoupon)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Button(action: {}, label: {
                    Text("Book Now")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth : .infinity, maxHeight: 30)
                        .background(Color.theme.secpurple)
                        .cornerRadius(10)
                        
                })
            }
            .frame(width: 180)
            
            Image("Bannergirl")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 123, height: 107)
        }
        .padding()
        .background(Color.theme.primarywhite)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 2.5, x: 0, y: 1.5)
        
    }
}

struct CouponCard_Previews: PreviewProvider {
    static var previews: some View {
        CouponCard()
            .padding()

    }
}
