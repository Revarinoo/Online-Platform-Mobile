//
//  OrderView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/11/21.
//

import SwiftUI

struct OrderView: View {
    
    @State var orderdate = Date()
    @State var ordertime = Date()
    @State var orderlocation = ""
    @Binding var cart: [ProductPackage]
    @Binding var locflag: Int
    // (yyyy-mm-dd time)
    
    private var tes: [ProductPackage] {
        return cart
    }
    
    //    init(){
    //        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    //    }
    
    var body: some View {
        VStack { //MARK: - Start VStack-1
            if locflag != 0 {
                VStack (alignment: .leading) { //MARK: - Start Vstack-2
                    Text("Deliver to")
                    CartCard(name: "Rumah Bandung", desc: "21, Jalan Jatinegara", type: "loc", cart: $cart, index: 0)
                } //MARK: - End Vstack-2
                .padding(.horizontal)
            }
            VStack (alignment: .leading) { //MARK: - Start Vstack-3
                Text("Package List")
                List {
                    ForEach(tes.indices) { idx in
                        CartCard(name: "\(cart[idx].quantity ?? 0) pcs \(cart[idx].type ?? "")", desc: "500K", type: "pack", cart: $cart, index: idx)
                    }
                }
                //                    ForEach(tes.indices) { idx in
                //                        CartCard(name: "\(cart[idx].quantity ?? 0) pcs \(cart[idx].type ?? "")", desc: "500K", type: "pack", cart: $cart, index: idx)
                //                    }
                //                    ForEach(cart, id: \.self) { product in
                //                        CartCard(name: "\(product.quantity ?? 0) pcs \(product.type ?? "")", desc: "500K", type: "pack", cart: $cart, index: 0)
                //                    }
            } //MARK: - End Vstack-3
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
            CartCard(name: "1 disc is applied", desc: "500K", type: "disc", cart: $cart, index: 0)
                .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("Order")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(cart: .constant([]), locflag: .constant(0))
    }
}
