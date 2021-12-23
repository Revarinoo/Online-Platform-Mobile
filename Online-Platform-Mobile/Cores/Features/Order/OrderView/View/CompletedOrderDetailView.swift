//
//  CompletedOrderDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 23/12/21.
//

import SwiftUI

struct CompletedOrderDetailView: View {
    var detailVM: OrderDetailViewModel
    
    var body: some View {
        VStack (spacing: 0) {
            VStack(alignment: .leading){
                Text("Result Link")
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack {
                        Text(detailVM.orderDetail.result_link)
                            .font(.custom(ThemeFont.displayRegular, size: 22))
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
                .frame(width: 358, height: 70)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            .padding()
            .padding(.top, 90)
            .edgesIgnoringSafeArea(.top)
            VStack(alignment: .leading){
                Text("Shipping Details")
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Courier")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                        Spacer()
                        Text(detailVM.orderDetail.shipping_courier)
                            .font(.custom(ThemeFont.displayRegular, size: 22))
                    }
                    .padding(.top)
                    Divider()
                    HStack {
                        Text(detailVM.orderDetail.tracking_number)
                            .font(.system(size: 22))
                    }
                    .padding(.bottom, 20)
                    .padding(.top)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            .padding()
            
            Spacer()
        }
    }
    
}

struct CompletedOrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOrderDetailView(detailVM: OrderDetailViewModel())
    }
}
