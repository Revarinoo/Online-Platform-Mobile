//
//  PaymentTime.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 01/12/21.
//

import SwiftUI

struct PaymentTime: View {
    var body: some View {
        HStack (alignment: .top, spacing: 15) {
            
            ZStack {
                Circle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(Color.theme.primary)
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.theme.primarywhite)
            }
            .frame(width: 44, height: 44)
            
            VStack (alignment: .leading, spacing: 5){
                
                Text("Complete Payment before")
                Text("12:45 PM")
                    .fontWeight(.medium)
                Text("Complete your transaction within 15 minutes")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .frame(width: 265, height: 33, alignment: .leading)
            .padding(.vertical,20)
            
        }
    }
}

struct PaymentTime_Previews: PreviewProvider {
    static var previews: some View {
        PaymentTime()
            .padding()
            .frame(width: 358, alignment: .top)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
    }
}
