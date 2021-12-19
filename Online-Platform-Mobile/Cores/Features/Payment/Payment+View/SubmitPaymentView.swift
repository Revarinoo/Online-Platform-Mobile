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
    @State private var selectedImage: Image? = Image("")

    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text("Payment time")
                    .foregroundColor(Color.theme.primary)
                    .fontWeight(.semibold)
                VStack {
                    DatePicker("Date", selection: $orderVM.order.schedule_date, displayedComponents: [.date])
                        .padding(.top)
                    Divider()
                    TextField("Bill name", text: $paymentVM.bill_name)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            UploadBox(isShowingPhotoPicker: $paymentVM.isShowingPhotoPicker, isUploaded: $paymentVM.isUploaded)
                .padding(.top, 20)
            self.selectedImage?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            Spacer()
            PrimaryButton(content: "Submit", maxWidth: 200, action: {
                
                
            }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                .sheet(isPresented: $paymentVM.isShowingPhotoPicker, content: {
                    ImagePicker(image: $selectedImage)
                })
            
        }
        .padding()
        .navigationTitle("Submit Payment")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct SubmitPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitPaymentView()
    }
}
