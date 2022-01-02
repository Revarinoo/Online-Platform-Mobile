//
//  TransactionDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 31/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Introspect

struct TransactionDetailView: View {
    var transaction: TransactionListModel
    var transactionVM: TransactionViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var uiTabBarController: UITabBarController?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack (alignment: .leading, spacing: 8) {
                Text("Date")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.init(hex: "979797"))
                Text(transaction.payment_date)
                    .font(.custom(ThemeFont.displayRegular, size: 22.5))
            }
            VStack (alignment: .leading, spacing: 8){
                Text("Bill Name")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.init(hex: "979797"))
                Text(transaction.bill_name)
            }
            VStack (alignment: .leading, spacing: 8){
                Text("Total Payment")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.init(hex: "979797"))
                Text("Rp " + Int(transaction.total_payment).rupiahFormatter())
            }
            VStack (alignment: .leading, spacing: 8){
                Text("Payment Proof")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.init(hex: "979797"))
                WebImage(url: URL(string: transaction.transfer_receipt))
                    .resizable()
                    .scaledToFill()
                    .padding(.leading, 100)
                    .frame(width: 100, height: 180)
            }
            Spacer()
            VStack(spacing: 9) {
                Button {
                    transactionVM.updateOrderStatus(orderId: transaction.id, status: "Upcoming")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Accept Payment")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: 358, height: 50)
                        .foregroundColor(Color.theme.primary)
                        .background(Color.theme.secondary)
                        .cornerRadius(15)
                }
                Button {
                    transactionVM.updateOrderStatus(orderId: transaction.id, status: "Rejected")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Decline Payment")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: 358, height: 50)
                        .foregroundColor(Color.red)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1))
                }
            }
            

        }
        .padding(.leading, 16)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .navigationTitle(transaction.user)
        .navigationBarTitleDisplayMode(.inline)
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
        .onDisappear {
            uiTabBarController?.tabBar.isHidden = false
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction: TransactionListModel(id: 1, user: "Kristian Budianto", payment_date: "Nov 11, 2021", bill_name: "Kritian Budianto", transfer_receipt: "http://127.0.0.1:8000/storage/images/gesal.jpg", total_payment: 650234), transactionVM: TransactionViewModel())
    }
}
