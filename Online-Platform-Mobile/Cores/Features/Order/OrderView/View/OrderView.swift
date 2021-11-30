//
//  OrderView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/11/21.
//  Edited by Reva

import SwiftUI

struct OrderView: View {
    
    @State var orderdate = Date()
    @State var ordertime = Date()
    @State var orderlocation = ""
    @State var cart: [ProductPackage]
    @State var locflag: Int
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 24) {
                if locflag != 0 {
                    VStack (alignment: .leading) {
                        Text("Deliver to")
                            .font(.custom(ThemeFont.displaySemiBold, size: 15))
                        CartCard(name: "Rumah Bandung", desc: "21, Jalan Jatinegara", type: "Loc", cart: $cart, index: 0)
                    }
                    .padding(.horizontal)
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
                        DatePicker("Date", selection: $orderdate, displayedComponents: [.date])
                            .padding(.top)
                        Divider()
                        DatePicker("Time", selection: $ordertime, displayedComponents: [.hourAndMinute])
                        Divider()
                        TextField("Location", text: $orderlocation)
                            .padding(.bottom)
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
            
            VStack {
                Spacer()
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
                    Text("Place Order")
                        .font(.custom(ThemeFont.displaySemiBold, size: 15))
                        .foregroundColor(Color.white)
                        .frame(width: 125, height: 33)
                        .background(Color.theme.primary)
                        .cornerRadius(10)

                }
                .padding([.leading, .trailing], 16)
                .frame(width: UIScreen.main.bounds.width, height: 93)
                .background(Color.init(hex: "F7F7F7"))
                
            }
        }
        .navigationTitle("Order")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func calculateCart(carts: [ProductPackage]) -> String {
        var total = 0
        for cart in carts {
            total += Int(cart.price!)
        }
        return total.rupiahFormatter()
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(cart: [ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1), ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1)], locflag: 1)
    }
}
