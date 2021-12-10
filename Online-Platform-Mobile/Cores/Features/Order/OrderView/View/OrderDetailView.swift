//
//  OrderDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 04/12/21.
//

import SwiftUI

struct OrderDetailView: View {
    
    //test pake vm lain dl
    @StateObject var orderVM = OrderViewModel()
    @State var locationorder = "Hotel Shangri-La, Jakarta Pusat"
    @State var orderdate = "Nov 17, 2021"
    @State var ordertime = "13 : 00"
    @State var Courier = "JNE REG"
    @State var resi = "TKAA -RAKO3HSKQN4"
    
    var body: some View {
        VStack {
            // Order Information
            VStack(alignment: .leading){
                Text("Order Information")
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(orderdate)
                            .font(.system(size: 22))
                    }
                    .padding(.top)
                    Divider()
                    HStack {
                        Text("Time")
                        Spacer()
                        Text(ordertime)
                            .font(.system(size: 22))
                    }
                    .padding(.top)
                    Divider()
                    Text(locationorder)
                        .padding(.vertical)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            .padding()
            // Shooping Details
            VStack(alignment: .leading){
                Text("Shopping Details")
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Courier")
                        Spacer()
                        Text(Courier)
                            .font(.system(size: 22))
                    }
                    .padding(.top)
                    Divider()
                    Text(resi)
                        .font(.system(size: 22))
                        .padding(.vertical)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            .padding()
            Spacer()
            PrimaryButton(content: "Reschedule", maxWidth: 200, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                .padding()
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView()
    }
}
