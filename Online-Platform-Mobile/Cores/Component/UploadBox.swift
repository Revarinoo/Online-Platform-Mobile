//
//  UploadBox.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 03/12/21.
//

import SwiftUI

struct UploadBox: View {
    @ObservedObject var paymentVM = PaymentViewModel()
    @Binding var isShowingPhotoPicker: Bool
    @Binding var isUploaded: Bool
    var body: some View {
        if paymentVM.isUploaded {
            HStack {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 43, height: 36)
                    .foregroundColor(Color.black)
                Text("payment receipt uploaded")
                    .foregroundColor(Color.black)
                Spacer()
                Text("Remove")
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        print("ini foto \(paymentVM.receiptImage)")
                        paymentVM.isUploaded = false
                        paymentVM.receiptImage = nil
                    }
            }
            .frame(maxWidth : .infinity, maxHeight: 20)
            .foregroundColor(Color.theme.darkGrey)
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.theme.darkGrey, style: StrokeStyle(lineWidth: 3, dash: [11]))
            )
        } else {
            Button ( action: {
                isShowingPhotoPicker = true
                
            }) {
                HStack {
                    Image(systemName: "icloud.and.arrow.up")
                    Text("Upload payment receipt")
                }
                .frame(maxWidth : .infinity, maxHeight: 20)
                .foregroundColor(Color.theme.darkGrey)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.theme.darkGrey, style: StrokeStyle(lineWidth: 3, dash: [11]))
                )
            }
        }
        
    }
}

struct UploadBox_Previews: PreviewProvider {
    static var previews: some View {
        UploadBox(isShowingPhotoPicker: .constant(false), isUploaded: .constant(false))
    }
}
