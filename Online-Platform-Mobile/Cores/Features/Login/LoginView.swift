//
//  LoginView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 14/10/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginVM = LoginViewModel()
    
    @State var selection: Role
    @AppStorage("role", store: .standard) var role = ""
    
    @State var isChecked:Bool = false
    
    var body: some View {
            ZStack {
                Color.theme.primary
                    .ignoresSafeArea()
                
                VStack (alignment: .leading){
                    Text("Sign In")
                        .foregroundColor(Color.theme.primarywhite)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 90)
                    
                    VStack {
                        VStack (alignment: .leading) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome Back")
                                    .font(.title3)
                                    .bold()
                                Text("You’ve been missed!")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                               
                            }
                            .padding()
                            
                            VStack {
                                
                                LabelForm(content: $loginVM.email, labeltext: "Email", type: "Text")
                                LabelForm(content: $loginVM.password, labeltext: "Password", type: "Password")
                                
                                VStack(alignment: .leading) {
                                    Text("Role")
                                        .foregroundColor(Color.gray)
                                    CustomPicker(selection: $selection, isLogin: true)
                                        .frame(height: 45)
                                }
                            }
                            .padding()
                        }
                        
                        Spacer()
                        
                        PrimaryButton(content: "Next", maxWidth: 290, action: {
                            self.role = selection.rawValue
                            loginVM.login(role: selection)
                        }, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                            .padding()
                        
                        VStack {
                            HStack {
                                Text("Not registered yet?")
                                    .foregroundColor(Color.theme.primary)
                                NavigationLink(
                                    destination: RegisterView(),
                                    label: {
                                        Text("Create Account")
                                            .bold()
                                            .foregroundColor(Color.theme.primary)
                                    })
                            }
                        }
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
                
            }
            .edgesIgnoringSafeArea([.top, .bottom])
            .alert(isPresented: $loginVM.redBanner, content: {
                Alert(title: Text("Failed"), message: Text(loginVM.failedMessage == "" ? "All field must be filled" : loginVM.failedMessage), dismissButton: .default(Text("OK")))
            })
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(selection: Role.Client)
    }
}

