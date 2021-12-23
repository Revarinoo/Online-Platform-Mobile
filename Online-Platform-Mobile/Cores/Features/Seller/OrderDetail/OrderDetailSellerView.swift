//
//  OrderDetailSellerView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI

enum OrderStatus: String {
    case pending = "Pending"
    case upcoming = "Upcoming"
    case completed = "Completed"
}

struct OrderDetailSellerView: View {
    
    @StateObject private var detailVM = OrderDetailSellerViewModel()
    var orderId: Int
    
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

                Spacer()
            }
            .onAppear {
                detailVM.getOrderDetail(orderId: orderId)
            }
        }
    }
}

struct OrderDetailSellerView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailSellerView(orderId: 28)
    }
}

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
