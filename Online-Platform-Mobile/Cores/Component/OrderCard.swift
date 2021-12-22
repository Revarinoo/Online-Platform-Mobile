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
        NavigationLink(destination: OrderDetailView(orderId: order.order_id)) {

                HStack {
                    HStack(alignment: .top, spacing: 18) {
                         WebImage(url: URL(string: order.photo))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .cornerRadius(6.48)
                        VStack (alignment: .leading, spacing: 3){
                            Text(order.name)
                                .foregroundColor(.black)
                                .font(.custom(ThemeFont.displayMedium, size: 18))
                            Text("Wedding")
                                .foregroundColor(Color.gray)
                                .font(.custom(ThemeFont.displayRegular, size: 13.5))
                            Label(order.order_date, systemImage: "calendar")
                                .foregroundColor(Color.gray)
                                .font(.custom(ThemeFont.displayRegular, size: 13.5))
                        }
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 29)
                        .padding()
                }
            
        }
    }
}

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        OrderCard(order: MyOrderModel(order_id: 1, photo: "", name: "", order_date: "", status: ""), isPending: true)
            .frame(width: 358, height: 95)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
    }
}
