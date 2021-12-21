//
//  OrderDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 04/12/21.
//  Edited by Reva

import SwiftUI
import Introspect

struct OrderDetailView: View {
    
    @StateObject private var orderDetailVM = OrderDetailViewModel()
    var orderId: Int
    @State var uiTabBarController: UITabBarController?
    
    var body: some View {
        VStack {
            if orderDetailVM.orderDetail.order_status == "Upcoming" {
                VStack(alignment: .leading){
                    Text("Order Information")
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Date")
                                .font(.custom(ThemeFont.displayRegular, size: 18))
                            Spacer()
                            Text(orderDetailVM.orderDetail.order_date)
                                .font(.custom(ThemeFont.displayRegular, size: 22))
                        }
                        .padding(.top)
                        Divider()
                        HStack {
                            Text("Time")
                                .font(.custom(ThemeFont.displayRegular, size: 18))
                                .font(.custom(ThemeFont.displayRegular, size: 22))
                            Spacer()
                            Text(orderDetailVM.orderDetail.order_time)
                                .font(.system(size: 22))
                        }
                        .padding(.top)
                        Divider()
                        Text(orderDetailVM.orderDetail.order_location)
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                }
                .padding()
                .padding(.top, 90)
                .edgesIgnoringSafeArea(.top)
            }
            if orderDetailVM.orderDetail.order_status == "Completed" {
                VStack(alignment: .leading){
                    Text("Shopping Details")
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Courier")
                            Spacer()
                            Text(orderDetailVM.orderDetail.shipping_courier)
                                .font(.system(size: 22))
                        }
                        .padding(.top)
                        Divider()
                        Text(orderDetailVM.orderDetail.tracking_number)
                            .font(.system(size: 22))
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                }
                .padding()
            }
            Spacer()
            PrimaryButton(content: "Reschedule", maxWidth: 200, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                .padding()
        }
        .navigationBarTitle("Order Detail", displayMode: .inline)
        .onAppear {
            orderDetailVM.getOrderDetail(orderId: self.orderId)
        }
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
        .onDisappear {
            uiTabBarController?.tabBar.isHidden = false
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(orderId: 1)
    }
}
