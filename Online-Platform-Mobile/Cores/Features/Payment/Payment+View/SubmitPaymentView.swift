//
//  SubmitPaymentView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 02/12/21.
//

import SwiftUI
import Introspect

struct SubmitPaymentView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @StateObject var paymentVM = PaymentViewModel()
    var orderId: Int
    @State var uiTabBarController: UITabBarController?
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text("Payment time")
                    .foregroundColor(Color.theme.primary)
                    .fontWeight(.semibold)
                VStack {
                    DatePicker("Date", selection: $paymentVM.submitPaymentModel.payment_date, displayedComponents: [.date])
                        .padding(.top)
                    Divider()
                    TextField("Bill name", text: $paymentVM.submitPaymentModel.bill_name)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            UploadBox(isShowingPhotoPicker: $paymentVM.isShowingPhotoPicker, isUploaded: paymentVM.submitPaymentModel.transfer_receipt.size.width == 0 ? .constant(false) : .constant(true), image: paymentVM.submitPaymentModel.transfer_receipt.size.width == 0 ? UIImage(systemName: "photo") : paymentVM.submitPaymentModel.transfer_receipt)
                .padding(.top, 20)
            Spacer()
            PrimaryButton(content: "Submit", maxWidth: 200, action: {
                paymentVM.submitPaymentModel.order_id = self.orderId
                paymentVM.submitPayment()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(900)) {
                    TabBarViewModel.shared.selected = 2
                }
            }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                .sheet(isPresented: $paymentVM.isShowingPhotoPicker, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $paymentVM.submitPaymentModel.transfer_receipt)
                })
                .disabled(paymentVM.submitPaymentModel.transfer_receipt == UIImage() || paymentVM.submitPaymentModel.bill_name == String() ? true : false)
            
                .opacity(paymentVM.submitPaymentModel.transfer_receipt == UIImage() || paymentVM.submitPaymentModel.bill_name == String() ? 0.4 : 1)
            
        }
        .padding()
        .navigationTitle("Submit Payment")
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

struct SubmitPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitPaymentView(orderId: 1)
    }
}
