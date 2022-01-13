//
//  PromoView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/01/22.
//

import SwiftUI

struct PromoView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(1..<8) {_ in
                    PromoCard()
                        .padding([.top, .bottom], 21)
                        .padding([.leading, .trailing], 18)
                        .frame(width: 358)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                }
            }
        }
        .navigationBarTitle(Text("Discount Coupon"),displayMode: .inline)
        
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
