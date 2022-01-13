//
//  PromoView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/01/22.
//

import SwiftUI

struct PromoView: View {
    @StateObject private var promoVM = PromoViewModel()
    @Binding var promo_id: Int
    @Binding var disc: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(promoVM.promos, id:\.id) { promo in
                    VStack(spacing: 12) {
                        PromoCard(promo: promo, promo_id: $promo_id, disc: $disc)
                            .padding([.top, .bottom], 21)
                            .padding([.leading, .trailing], 18)
                            .frame(width: 358)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 3, x: 0, y: 3)
                        .padding([.leading, .trailing], 8)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarTitle(Text("Discount Coupon"),displayMode: .inline)
        .onAppear {
            promoVM.getAllPromo()
        }
        .onChange(of: disc) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView(promo_id: .constant(1), disc: .constant(1))
    }
}
