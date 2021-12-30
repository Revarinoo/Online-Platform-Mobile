//
//  RegisterView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/10/21.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerVM = RegisterViewModel()
    
    @State var isChecked:Bool = false

    @State var selection: Role = .Client
    var tnc = "By creating an account, you agree to our Terms and Conditions"
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.primary
                    .ignoresSafeArea()
                
                VStack (alignment: .leading){
                    Text("Create Account")
                        .foregroundColor(Color.theme.primarywhite)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack (spacing: 5) {
                        VStack (alignment: .leading) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome")
                                    .font(.title3)
                                    .bold()
                                Text("hello friends sign up to continue")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            
                            FormView(registerVM: registerVM, selection: $selection)
                            
                            Button(action: toggle){
                                HStack (alignment: .firstTextBaseline){
                                    Image(systemName: isChecked ? "checkmark.square": "square")
                                    Text(tnc)
                                        .multilineTextAlignment(.leading)
                                }
                                .foregroundColor(Color.theme.primary)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        
                        PrimaryButton(content: "Sign Up", maxWidth: 330, action: {
                            registerVM.register(role: selection)
                            print(selection.rawValue)
                        }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                            .padding(15)
                        
                        VStack {
                            HStack {
                                Text("Already have an account?")
                                    .foregroundColor(Color.theme.primary)
                                NavigationLink(
                                    destination: LoginView(selection: .Client).navigationBarBackButtonHidden(true),
                                    label: {
                                        Text("Sign In")
                                            .bold()
                                            .foregroundColor(Color.theme.primary)
                                    })
                            }
                        }
                        .padding(.top,5)
                        Spacer()
                        if registerVM.redBanner {
                            ZStack {
                                Rectangle()
                                    .fill(Color.red)
                                Text(registerVM.failedMessage)
                                    .foregroundColor(Color.white)
                            }.frame(width: 390, height: 50, alignment: .center)
                        }
                        Spacer()
                        
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
                
            }
            .navigationBarHidden(true)
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(selection: .Client)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}

struct FormView: View {
    @State var registerVM: RegisterViewModel
    @Binding var selection: Role
    
    var body: some View {
        VStack (alignment: .leading){
            LabelForm(content: $registerVM.name, labeltext: "Names", type: "Text")
            LabelForm(content: $registerVM.email, labeltext: "Email", type: "Text")
            LabelForm(content: $registerVM.password, labeltext: "Password", type: "Password")
            
            VStack(alignment: .leading) {
                Text("Role")
                    .foregroundColor(Color.gray)
                CustomPicker(selection: $selection, isLogin: false)
            }
            
        }
        .padding()
    }
}
