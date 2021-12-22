//
//  ProfileView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 15/12/21.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
    @AppStorage("JWT", store: .standard) var token = ""
    
    var screenwidth =  UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Image("welcomepage")
                .resizable()
                .frame(width: 125, height: 125)
                .cornerRadius(10)
                .padding()
            
            HStack {
                VStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        Text(profileVM.seller.name)
                    }
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        Text(profileVM.seller.name)
                    }
                    VStack(alignment: .leading) {
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        Text(profileVM.seller.name)
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
