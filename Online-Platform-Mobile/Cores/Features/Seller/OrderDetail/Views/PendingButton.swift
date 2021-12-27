//
//  PendingButton.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import SwiftUI

struct PendingButton: View {
    var vm: OrderDetailSellerViewModel
    var orderId: Int
    
    var body: some View {
        VStack (spacing: 9) {
            Button {
                vm.updateOrder(orderId: orderId, status: "Upcoming")
            } label: {
                Text("Accept")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.theme.primary)
                    .background(Color.theme.secondary)
                    .cornerRadius(15)
            }
            
            Button {
                vm.updateOrder(orderId: orderId, status: "Rejected")
            } label: {
                Text("Decline")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.theme.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.theme.primary, lineWidth: 1)
                    )
            }
        }
        .padding(.top, 42)
    }
}
