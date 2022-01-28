//
//  OrderListView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 23/12/21.
//

import SwiftUI
import Introspect

struct OrderListView: View {
    
    @State private var orderstatus = 0
    @State private var count = 5
    @StateObject private var orderVM = SellerOrderViewModel()
    @State var uiTabBarController: UITabBarController?
    @State private var isActive = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.primary)
        UISegmentedControl.appearance().backgroundColor = .white
        
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.theme.darkGrey)], for: .normal)
    }
    
    var body: some View {
        VStack {
            Divider().background(Color.init(hex: "A7A7A7"))
            Picker("Order Status", selection: $orderstatus) {
                Text("Pending").tag(0)
                Text("In Progress").tag(1)
                Text("Completed").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView (.vertical, showsIndicators: false, content: {
                VStack {
                    switch orderstatus {
                    case 0:
                        AllOrderView(orders: orderVM.pendingOrders, client: false)
                    case 1:
                        AllOrderView(orders: orderVM.upcomingOrders, client: false)
                    case 2:
                        AllOrderView(orders: orderVM.completedOrders, client: false)
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
            orderVM.getAllOrderSeller()
        }
        .navigationBarItems(trailing:
                                NavigationLink(destination: ChatList(), isActive: $isActive) {
            Button(action: {
                isActive.toggle()
            }) {
            Image(systemName: "message").imageScale(.large)
                .foregroundColor(Color.theme.primary)
            }
        }
        )
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = false
            uiTabBarController = UITabBarController
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}

