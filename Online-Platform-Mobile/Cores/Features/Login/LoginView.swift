//
//  LoginView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 14/10/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginVM = LoginViewModel()
    
    @State var isChecked:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.primary
                    .ignoresSafeArea()
                
                VStack (alignment: .leading){
                    Text("Sign In")
                        .foregroundColor(Color.theme.primarywhite)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
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
                                LabelForm(content: loginVM.name, labeltext: "Email")
                                LabelForm(content: loginVM.name, labeltext: "Password")
                            }
                            .padding()
                        }
                        
                        Spacer()
                        
                        PrimaryButton(content: "Next", maxWidth: 290, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                            .padding()
                        
                        Spacer()
                    }
                    .background(Color.theme.primarywhite)
                    .cornerRadius(10)
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

