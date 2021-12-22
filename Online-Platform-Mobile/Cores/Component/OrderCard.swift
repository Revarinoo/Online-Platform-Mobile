//
//  OrderCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 04/12/21.
//  Edited by Reva

import SwiftUI
import SDWebImageSwiftUI

struct OrderCard: View {
    
    var order: MyOrderModel
    var isPending: Bool
    @State var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top, spacing: 18) {
                WebImage(url: URL(string: order.photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 57, height: 57)
                    .cornerRadius(6.48)
    
                VStack (alignment: .leading, spacing: 5){
                    Text(order.name)
                        .foregroundColor(.black)
                        .font(.custom(ThemeFont.displayMedium, size: 18))
                    Label(order.order_date, systemImage: "calendar")
                        .foregroundColor(Color.gray)
                        .font(.custom(ThemeFont.displayRegular, size: 15))
                }
            }
            .padding(EdgeInsets(top: 21, leading: 16, bottom: 0, trailing: 0))
            
            HStack {
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Cancel")
                        .font(.custom(ThemeFont.displayMedium, size: 15))
                        .foregroundColor(Color.red)
                        .frame(width: 113, height: 38)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.red, lineWidth: 1)
                        )
                })
                    .opacity(isPending ? 1 : 0)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Cancel Order"), message: Text("Are you sure want to cancel order?"), primaryButton: .default(Text("No")), secondaryButton: .default(Text("Yes"), action: {
                OrderViewModel.shared.cancelOrder(orderId: order.order_id)
            }))
        }
    }
}

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        OrderCard(order: MyOrderModel(order_id: 1, photo: "", name: "", order_date: "", status: ""), isPending: true)
            .frame(width: 357, height: 141)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
    }
}
