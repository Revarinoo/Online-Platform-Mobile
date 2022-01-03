//
//  SubmitComplainView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import SwiftUI
import TextView

struct SubmitComplainView: View {
    @StateObject private var complainVM = SubmitComplainViewModel()
    var orderId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Complain details")
                .font(.custom(ThemeFont.displaySemiBold, size: 15))
            TextArea(text: $complainVM.complainMessage, placeholder: "Write your complain here...", isEditing: .constant(true))
            Spacer()
            Button {
                complainVM.submitComplain(orderId: orderId)
                showAlert.toggle()
            } label: {
                Text("Submit")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .foregroundColor(Color.theme.primary)
                    .background(Color.theme.secondary)
                    .cornerRadius(15)
                    .padding(.bottom, 10)
            }
            .disabled(complainVM.complainMessage == "" ? true : false)
            .opacity(complainVM.complainMessage == "" ? 0.5 : 1)

        }
        .padding(.top, 16)
        .navigationTitle("Submit Complain")
        .onTapGesture {
            self.dismissKeyboard()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Your complain successfully submitted, discuss with the seller via chat and wait for the Admin to verify your complain"), dismissButton: .default(Text("OK")) {
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            })
        }

        }
    }


struct SubmitComplainView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitComplainView(orderId: 1)
    }
}
