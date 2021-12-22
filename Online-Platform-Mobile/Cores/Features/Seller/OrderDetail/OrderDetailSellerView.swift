//
//  OrderDetailSellerView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI

struct OrderDetailSellerView: View {
    
    @StateObject private var detailVM = OrderDetailSellerViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("Order Information")
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Date")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                        Spacer()
                        Text("Nov 17, 2021")
                            .font(.custom(ThemeFont.displayRegular, size: 22))
                    }
                    .padding(.top)
                    Divider()
                    HStack {
                        Text("Time")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .font(.custom(ThemeFont.displayRegular, size: 22))
                        Spacer()
                        Text("15:24")
                            .font(.system(size: 22))
                    }
                    .padding(.top)
                    Divider()
                    Text("Hotel Shangri-La, Jakarta Pusat")
                        .font(.custom(ThemeFont.displayRegular, size: 18))
                        .padding(.vertical)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            .padding()
            
            VStack {
                Text("Package List")
                    .fontWeight(.semibold)
                
            }
            Spacer()
        }
        .onAppear {
            detailVM.getOrderDetail(orderId: 28)
        }
    }
}

struct OrderDetailSellerView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailSellerView()
    }
}
