//
//  MyOrderView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 04/12/21.
//

import SwiftUI

struct MyOrderView: View {
    
    @State private var orderstatus = 0
    @State private var count = 5
    @StateObject var orderVM = OrderViewModel.shared
    
    //to change segmented color
    init() {
        //this changes the "thumb" that selects between items
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.primary)
        //and this changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = .white
        
        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)
        
        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.theme.darkGrey)], for: .normal)
    }
    
    var body: some View {
        VStack {
            Divider().background(Color.init(hex: "A7A7A7"))
            Picker("Order Status", selection: $orderstatus) {
                Text("Pending").tag(0)
                Text("Upcoming").tag(1)
                Text("Completed").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView (.vertical, showsIndicators: false, content: {
                VStack {
                    switch orderstatus {
                    case 0:
                        PendingOrderView(orders: orderVM.pendingOrders, client: true)
                    case 1:
                        AllOrderView(orders: orderVM.upcomingOrders, client: true)
                    case 2:
                        AllOrderView(orders: orderVM.completedOrders, client: true)
                    default:
                        Text("")
                    }
                }
                .padding(.horizontal)
            })
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            orderVM.getAllOrder()
        }
        
    }
}

struct AllOrderView: View {
    var orders: [MyOrderModel]
    var client: Bool
    
    var body: some View {
        ForEach(orders, id: \.id) { data in
            NavigationLink(destination: client ? AnyView(OrderDetailView(orderId: data.order_id, sellerImage: data.photo)) : AnyView(OrderDetailSellerView(orderId: data.order_id))) {
                OrderCard(order: data, isPending: false, isClient: client)
                    .frame(width: 357, height: 141)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
        }
    }
}

struct PendingOrderView: View {
    var orders: [MyOrderModel]
    var client: Bool
    
    var body: some View {
        ForEach(orders, id: \.id) { data in
            OrderCard(order: data, isPending: true, isClient: client)
                .frame(width: 357, height: 141)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
        }
    }
}

struct MyOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrderView()
    }
}
