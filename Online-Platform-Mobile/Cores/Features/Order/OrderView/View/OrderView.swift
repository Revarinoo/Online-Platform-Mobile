//
//  OrderView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/11/21.
//  Edited by Reva

import SwiftUI
import Introspect

struct OrderView: View {
    
    @State var orderdate = Date()
    @State var ordertime = Date()
    @State var orderlocation = ""
    @State var cart: [ProductPackage]
    @State var locationFlag = false
    @StateObject var orderVM = OrderViewModel()
    @State var uiTabBarController: UITabBarController?
    @State var location = "Location"
    @State var shipping = "Choose your address"
    @State private var navigateToPromo = false
    @State var promo_id = 0
    @State var disc = 0
    
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                VStack (spacing: 24) {
                    if locationFlag {
                        NavigationLink(destination: ChooseLocationView(location: $shipping)) {
                            VStack (alignment: .leading) {
                                Text("Deliver to")
                                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                CartCard(name: $shipping, desc: "", type: "Loc")
                            }
                            .padding(.horizontal)
                        }
                    }
                    VStack (alignment: .leading) {
                        Text("Package List")
                            .font(.custom(ThemeFont.displaySemiBold, size: 15))
                        VStack {
                            ForEach(cart, id: \.self) { data in
                                CartCardView(package: data, carts: $cart, type: data.type!)
                            }
                        }
                        .padding([.top, .bottom], 21)
                        .padding([.leading, .trailing], 18)
                        .frame(width: 358)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    VStack (alignment: .leading){
                        Text("Order Details")
                        VStack {
                            DatePicker("Date", selection: $orderVM.order.schedule_date, displayedComponents: [.date])
                                .padding(.top)
                            Divider()
                            DatePicker("Time", selection: $orderVM.order.schedule_time, displayedComponents: [.hourAndMinute])
                            Divider()
                            NavigationLink(destination: ChooseLocationView(location: $orderVM.order.location)){
                                HStack {
                                    Text(orderVM.order.location)
                                        .font(.custom(ThemeFont.displayRegular, size: 18))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("Choose Location")
                                        .font(.custom(ThemeFont.displayRegular, size: 18))
                                        .foregroundColor(.black)
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding(.bottom, 16)
                            .padding(.top, 10)
                        }
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                        
                    }
                    .padding()
                    Spacer()
                    
                }
                .padding(.top, 16)
            }
            .padding(.bottom, 170)
            VStack {
                Spacer()
                NavigationLink(destination: PromoView(promo_id: $promo_id, disc: $disc), isActive: $navigateToPromo) {
                    CartCard(name: .constant(promo_id == 0 ? "Apply your coupon code" : "1 discount is applied"), desc: "", type: "Disc")
                        .padding([.leading, .trailing], 16)
                }
                HStack {
                    VStack (alignment: .leading) {
                        Text("Total Price")
                            .font(.custom(ThemeFont.displayMedium, size: 14))
                            .foregroundColor(Color.theme.darkGrey)
                        HStack (alignment: .firstTextBaseline) {
                            Text("IDR")
                                .font(.custom(ThemeFont.displayMedium, size: 14))
                                .foregroundColor(Color.theme.primary)
                            Text("\(calculateCart(carts: cart))")
                                .font(.custom(ThemeFont.displayBold, size: 24))
                                .foregroundColor(Color.theme.primary)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: PaymentView(amountToPay: calculateCart(carts: cart), orderId: orderVM.orderId), isActive: $orderVM.isNavigate) {
                        Button {
                            
                            orderVM.createOrder(carts: cart, shipping: locationFlag ? shipping : "", promoId: promo_id, disc: disc)
                        } label: {
                            Text("Place Order")
                                .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                .foregroundColor(Color.white)
                                .frame(width: 125, height: 33)
                                .background(Color.theme.primary)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom], 16)
                .frame(width: UIScreen.main.bounds.width, height: 93)
                .background(Color.init(hex: "F7F7F7"))
                
            }
        }
        
        .navigationTitle("Order")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
    }
    
    private func calculateCart(carts: [ProductPackage]) -> String {
        var total = 0
        for cart in carts {
            total += Int(cart.price!)
        }
        if promo_id != 0 {
            let discount = (total * self.disc)/100
            total -= discount
        }
        total += orderVM.randValue
        return total.rupiahFormatter()
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(cart: [ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1), ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1)], locationFlag: true)
    }
}
