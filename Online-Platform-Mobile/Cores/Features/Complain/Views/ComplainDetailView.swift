//
//  ComplainDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import SwiftUI
import TextView
import Introspect

struct ComplainDetailView: View {
    var complainVM: AdminComplainViewModel
    var complainId: Int
    var complainModel: ComplainModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var uiTabBarController: UITabBarController?
    
    init(vm: AdminComplainViewModel, id: Int, model: ComplainModel) {
        self.complainVM = vm
        self.complainId = id
        self.complainModel = model
    }
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text("Complain details")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.theme.darkGrey)
                TextArea(text: .constant(complainModel.complain_detail), placeholder: "", isEditing: .constant(false))
            }
            .padding(.top, 16)
            .padding(.bottom, 22)
            VStack (alignment: .leading) {
                Text("Result Link")
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.theme.darkGrey)
                TextArea(text: .constant(complainModel.result_link), placeholder: "", isEditing: .constant(false), height: 70)
            }
            Spacer()
            VStack(spacing: 9) {
                Button {
                    complainVM.updateComplain(orderId: complainId, status: "Accepted")
                } label: {
                    Text("Accept Complain")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .foregroundColor(Color.theme.primary)
                        .background(Color.theme.secondary)
                        .cornerRadius(15)
                }
                Button {
                    complainVM.updateComplain(orderId: complainId, status: "Declined")
                } label: {
                    Text("Decline Complain")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .foregroundColor(Color.red)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red , lineWidth: 2))
                        .cornerRadius(15)
                }
            }
            .padding(.bottom, 28)
        }
        .navigationTitle(complainModel.client_name)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: complainVM.navigate) { _ in
            presentationMode.wrappedValue.dismiss()
        }
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
    }
}

struct ComplainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComplainDetailView(vm: AdminComplainViewModel(), id: 1, model: ComplainModel(id: 1, client_name: "Christie Sutoyo", complain_detail: "Hasil revisi foto tidak menunjukkan perubahan dibandingkan hasil pertama kali yang diberikan", result_link: "https://drive.google.com/drive/folders/1WE"))
    }
}


