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
    @State var showReschedule = false
    @State private var navigateReview = false
    var sellerImage: String
    @State private var showResult = false
    
    var body: some View {
        VStack {
            if orderDetailVM.orderDetail.order_status != OrderStatus.completed.rawValue {
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
            if orderDetailVM.orderDetail.order_status == OrderStatus.completed.rawValue {
                CompletedOrderDetailView(detailVM: orderDetailVM)
            }
            Spacer()
            if orderDetailVM.orderDetail.order_status == OrderStatus.completed.rawValue && orderDetailVM.orderDetail.already_reviewed == 0 {
                NavigationLink(destination: GiveOrderReviewView(orderId: orderId, sellerImage: self.sellerImage), isActive: $navigateReview) {
                    PrimaryButton(content: "Review", maxWidth: 200, action: {
                        navigateReview.toggle()
                    }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                        .padding()
                }
                .disabled(orderDetailVM.orderDetail.order_status == OrderStatus.completed.rawValue && orderDetailVM.orderDetail.already_reviewed == 0 ? false : true)
            }
            else if orderDetailVM.orderDetail.order_status != OrderStatus.completed.rawValue {
                VStack (spacing: -15) {
                    PrimaryButton(content: "Reschedule", maxWidth: 200, action: {
                        showReschedule.toggle()
                    }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                        .padding()
                        .disabled(orderDetailVM.isExpired ? true : false)
                        .opacity(orderDetailVM.isExpired ? 0.5 : 1)
                    
                    NavigationLink(destination: OrderResultView(orderId: orderId), isActive: $showResult) {
                        PrimaryButton(content: "Result", maxWidth: 200, action: {
                            showResult.toggle()
                        }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                            .padding()
                    }
                }
            }
        }
        .navigationBarTitle("Order Detail", displayMode: .inline)
        .onAppear {
            orderDetailVM.getOrderDetail(orderId: self.orderId)
        }
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
        .fullScreenCover(isPresented: $showReschedule) {
            RescheduleView(orderDetailVM: orderDetailVM, orderId: orderId, isShowed: $showReschedule)
                .animation(.linear)
                .transition(.opacity)
                .background(BackgroundCleanerView())
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(orderId: 1, sellerImage: "")
    }
}

struct BackgroundCleanerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
    let view = UIView()
    
        DispatchQueue.main.async {
        view.superview?.superview?.backgroundColor = .clear
        
    }
        return view
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
