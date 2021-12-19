//
//  PaymentView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/12/21.
//

import SwiftUI

struct PaymentView: View {
    var amountToPay: String
    var orderId: Int
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text("Payment time")
                    .foregroundColor(Color.theme.primary)
                    .fontWeight(.semibold)
                PaymentTime()
                    .padding()
                    .frame(width: 358, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            VStack(alignment: .leading) {
                Text("Transfer to")
                    .foregroundColor(Color.theme.primary)
                    .fontWeight(.semibold)
                Transfer(amount: amountToPay)
                    .padding()
                    .frame(width: 358, height: 167, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            
            VStack (spacing: -3) {
                Image(systemName: "triangle.fill")
                    .foregroundColor(Color.theme.primary)
                Image("Paymentalert")
            }
            .padding(.top, -25)
            Spacer()
            NavigationLink(destination: SubmitPaymentView()) {
                
                Text("I Have Completed Payment")
                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                    .frame(maxWidth : .infinity, maxHeight: 50)
                    .background(Color.theme.secondary)
                    .foregroundColor(Color.theme.primary)
                    .cornerRadius(10)
            }
            
            
        }
        .padding()
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(amountToPay: "100000", orderId: 0)
    }
}