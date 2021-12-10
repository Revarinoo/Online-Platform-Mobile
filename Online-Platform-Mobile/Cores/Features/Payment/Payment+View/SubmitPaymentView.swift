//
//  SubmitPaymentView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 02/12/21.
//

import SwiftUI

struct SubmitPaymentView: View {
    // test pake orderVm dl
    @StateObject var orderVM = OrderViewModel.shared
    @State private var imageTest = UIImage(named: "welcomepage")!
    @State private var isShowingPhotoPicker = false
    
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
                    TextField("Bill name", text: $orderVM.order.location)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            }
            UploadBox(isShowingPhotoPicker: $isShowingPhotoPicker)
                .padding(.top, 20)
            Image(uiImage: imageTest)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 300)
//                .onTapGesture { isShowingPhotoPicker = true
//                    print(isShowingPhotoPicker)
//                }
            Spacer()
            PrimaryButton(content: "Submit", maxWidth: 200, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
            
        }
        .padding()
        .navigationTitle("Submit Payment")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingPhotoPicker, content: {
            PhotoPicker(testImage: $imageTest)
        })
    }
}

struct SubmitPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitPaymentView()
    }
}
