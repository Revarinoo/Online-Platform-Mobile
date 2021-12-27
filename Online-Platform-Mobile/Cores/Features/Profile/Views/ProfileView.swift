//
//  ProfileView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 15/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @AppStorage("JWT", store: .standard) var token = ""
    @StateObject private var profileVM = UserHelper.shared
    @State var showEditPage = false
    
    var screenwidth =  UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Divider()
            WebImage(url: URL(string: profileVM.user.photo))
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(10)
                .padding()
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Name")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .foregroundColor(Color.gray)
                        Text(profileVM.user.name)
                            .font(.custom(ThemeFont.displayRegular, size: 22.5))
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .foregroundColor(Color.gray)
                        Text(profileVM.user.email)
                            .font(.custom(ThemeFont.displayRegular, size: 22.5))
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Phone Number")
                            .font(.custom(ThemeFont.displayRegular, size: 18))
                            .foregroundColor(Color.gray)
                        Text(profileVM.user.phone_number)
                            .font(.custom(ThemeFont.displayRegular, size: 22.5))
                    }
                    Spacer()
                }
                Spacer()
                
            }
            .padding()
            PrimaryButton(content: "Log Out", maxWidth: screenwidth, action: {
                self.token = "" 
            }, btnColor: Color.red, textColor: Color.white)
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showEditPage.toggle()
                } label: {
                    Text("Edit")
                        .foregroundColor(Color.theme.primary)
                }
            }
        }
        .sheet(isPresented: $showEditPage) {
            EditProfileView(showThisPage: $showEditPage)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
