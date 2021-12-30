//
//  OrderDetailSellerView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI
import Introspect

enum OrderStatus: String {
    case pending = "Pending"
    case upcoming = "Upcoming"
    case needRevision = "Need Revision"
    case notSubmitted = "Not Submitted"
    case waiting = "Waiting"
    case completed = "Completed"
}

struct OrderDetailSellerView: View {
    
    @StateObject private var detailVM = OrderDetailSellerViewModel()
    var orderId: Int
    @State var uiTabBarController: UITabBarController?
    @State private var isChat = false
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading){
                    Text("Order Information")
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Date")
                                .font(.custom(ThemeFont.displayRegular, size: 18))
                            Spacer()
                            Text(detailVM.detailModel.schedule_date)
                                .font(.custom(ThemeFont.displayRegular, size: 22))
                        }
                        .padding(.top)
                        Divider()
                        HStack {
                            Text("Date")
                                .font(.custom(ThemeFont.displayRegular, size: 18))
                                .font(.custom(ThemeFont.displayRegular, size: 22))
                            Spacer()
                            Text(detailVM.detailModel.schedule_time)
                                .font(.system(size: 22))
                        }
                        .padding(.top)
                        Divider()
                        Text(detailVM.detailModel.order_location)
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                }
                .padding()
                
                VStack (alignment: .leading) {
                    Text("Package List")
                        .fontWeight(.semibold)
                    VStack {
                        ForEach(detailVM.detailModel.package, id: \.id) { data in
                            PackageView(package: data)
                        }
                    }
                    .padding([.top, .bottom], 21)
                    .padding([.leading, .trailing], 18)
                    .frame(width: 358)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                }
                if detailVM.showDeliveryAddress {
                    VStack (alignment: .leading, spacing: 9) {
                        Text("Deliver to")
                            .fontWeight(.semibold)
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.theme.primary)
                                        .frame(width: 53, height: 53)
                                    Image("loc")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 19.5, height: 23.69)
                                    .foregroundColor(Color.theme.primarywhite)
                                }
                                VStack (alignment: .leading) {
                                    Text(detailVM.detailModel.client_name)
                                        .font(.custom(ThemeFont.displayMedium, size: 18))
                                    Text(detailVM.detailModel.shipping_address)
                                        .font(.custom(ThemeFont.displayRegular, size: 13.5))
                                }
                            }
                        .padding([.top, .bottom], 21)
                        .padding([.leading, .trailing], 18)
                        .frame(width: 358)
                        .background(Color.white)
                        .cornerRadius(10)
                    .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                    }
                    .padding(.top, 24)
                }
                Spacer()
                if detailVM.detailModel.order_status == OrderStatus.pending.rawValue {
                    PendingButton(vm: detailVM, orderId: self.orderId)
                }
                else if detailVM.detailModel.order_status != OrderStatus.completed.rawValue {
                    InProgessButton(vm: detailVM, orderId: self.orderId)
                }

            }
            .navigationTitle("Order Detail")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: ChatList(), isActive: $isChat) {
                Button(action: {
                    isChat.toggle()
                }) {
                Image(systemName: "message").imageScale(.large)
                    .foregroundColor(Color.theme.primary)
                }
            }
            )
            .onAppear {
                detailVM.getOrderDetail(orderId: orderId)
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
}

struct OrderDetailSellerView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailSellerView(orderId: 2)
    }
}

struct InProgessButton: View {
    @StateObject var vm: OrderDetailSellerViewModel
    var orderId: Int
    
    var body: some View {
        VStack (spacing: 9) {
            Button {
                
            } label: {
                Text("Submit Result")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.theme.primary)
                    .background(Color.theme.secondary)
                    .cornerRadius(15)
            }
            .disabled(vm.detailModel.order_status == OrderStatus.waiting.rawValue ? true : false)
            .opacity(vm.detailModel.order_status == OrderStatus.waiting.rawValue ? 0.3 : 1)
            
            Button {
                
            } label: {
                Text("View Revision")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.theme.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.theme.primary, lineWidth: 1)
                    )
            }
            .disabled(vm.detailModel.order_status == OrderStatus.needRevision.rawValue ? false : true)
            .opacity(vm.detailModel.order_status == OrderStatus.needRevision.rawValue ? 1 : 0.3)
        }
        .padding(.top, 42)
    }
}
