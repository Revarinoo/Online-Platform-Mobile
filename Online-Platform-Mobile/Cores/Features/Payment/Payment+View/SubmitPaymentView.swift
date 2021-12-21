//
//  SubmitPaymentView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 02/12/21.
//

import SwiftUI

struct SubmitPaymentView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @StateObject var paymentVM = PaymentViewModel()
    var orderId: Int
    @State private var selectedImage: UIImage = UIImage()

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
            Image(uiImage: self.selectedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            Spacer()
            NavigationLink(destination: TabBar(selection: 2).navigationBarHidden(true).navigationBarBackButtonHidden(true).ignoresSafeArea(), isActive: $paymentVM.isFinishedUploading) {
                PrimaryButton(content: "Submit", maxWidth: 200, action: {
                    paymentVM.submitPaymentModel.order_id = self.orderId
                    paymentVM.submitPayment()
                    
                }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                    .sheet(isPresented: $paymentVM.isShowingPhotoPicker, content: {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $paymentVM.submitPaymentModel.transfer_receipt)
                    })
            }
            
        }
        .padding()
        .navigationTitle("Submit Payment")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct SubmitPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitPaymentView(orderId: 1)
    }
}
