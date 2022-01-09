//
//  CompletedOrderDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 23/12/21.
//

import SwiftUI
import TextView
import MobileCoreServices

struct CompletedOrderDetailView: View {
    var detailVM: OrderDetailViewModel
    @State private var copyLogo = "doc.on.doc"
    @State private var isCopied = false
    
    var body: some View {
        VStack (spacing: 0) {
            VStack(alignment: .leading){
                Text("Result Link")
                    .fontWeight(.semibold)
                
                ZStack {
                    Text(detailVM.orderDetail.result_link)
                        .padding([.top, .bottom], 21)
                        .padding([.leading, .trailing], 18)
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 4, x: 0, y: 2)
                    HStack {
                        Spacer()
                        Image(systemName: copyLogo)
                            .padding(.trailing, 16)
                            .onTapGesture {
                                UIPasteboard.general.setValue(detailVM.orderDetail.result_link, forPasteboardType: "public.plain-text")
                                self.copyLogo = "doc.on.doc.fill"
                                self.isCopied.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isCopied.toggle()
                                    self.copyLogo = "doc.on.doc"
                                }
                            }
                    }
                }
                
                if isCopied {
                    HStack {
                        Spacer()
                        Text("Copied!")
                            .foregroundColor(Color.theme.darkGrey)
                            .font(.custom(ThemeFont.displayRegular, size: 12))
                    }
                }
            }
            .padding()
            .padding(.top, 90)
            .edgesIgnoringSafeArea(.top)
            if detailVM.orderDetail.tracking_number != "" {
                VStack(alignment: .leading){
                    Text("Shipping Details")
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Courier")
                                .font(.custom(ThemeFont.displayRegular, size: 18))
                            Spacer()
                            Text(detailVM.orderDetail.shipping_courier)
                                .font(.custom(ThemeFont.displayRegular, size: 22))
                        }
                        .padding(.top)
                        Divider()
                        HStack {
                            Text(detailVM.orderDetail.tracking_number)
                                .font(.system(size: 22))
                        }
                        .padding(.bottom, 20)
                        .padding(.top)
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                }
                .padding()
            }
            
            
            Spacer()
        }
    }
    
}

struct CompletedOrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOrderDetailView(detailVM: OrderDetailViewModel())
    }
}
