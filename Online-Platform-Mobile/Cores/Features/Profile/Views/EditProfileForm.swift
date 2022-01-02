//
//  EditProfileForm.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 28/12/21.
//

import SwiftUI

struct EditProfileForm: View {
    @Binding var profile: EditProfile
    
    var body: some View {
        VStack (spacing: 18) {
            VStack(alignment: .leading, spacing: 12){
                Text("Full Name")
                    .font(Font.custom(ThemeFont.displayRegular, size: 14))
                    .foregroundColor(Color.theme.darkGrey)
                TextField("Enter your full name", text: $profile.name).textFieldStyle(OvalTextFieldStyleForm())
            }
            VStack(alignment: .leading, spacing: 12){
                Text("Email")
                    .font(Font.custom(ThemeFont.displayRegular, size: 14))
                    .foregroundColor(Color.theme.darkGrey)
                TextField("Enter your email", text: $profile.email).textFieldStyle(OvalTextFieldStyleForm())
            }
            VStack(alignment: .leading, spacing: 12){
                Text("Phone Number")
                    .font(Font.custom(ThemeFont.displayRegular, size: 14))
                    .foregroundColor(Color.theme.darkGrey)
                TextField("Enter phone number", value: $profile.phoneNumber, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(OvalTextFieldStyleForm())
            }
            VStack(alignment: .leading, spacing: 12){
                Text("Password")
                    .font(Font.custom(ThemeFont.displayRegular, size: 14))
                    .foregroundColor(Color.theme.darkGrey)
                SecureField("Enter your password", text: $profile.password).textFieldStyle(OvalTextFieldStyleForm())
            }
        }
        .padding([.leading, .trailing], 16)
    }
}

struct EditProfileForm_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileForm(profile: .constant(EditProfile()))
            .previewLayout(.sizeThatFits)
    }
}
