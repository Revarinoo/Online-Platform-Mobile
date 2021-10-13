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
    @State var role: Role
    
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
                    
                    VStack {
                        VStack (alignment: .leading) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome")
                                    .font(.title3)
                                    .bold()
                                Text("hello friends sign up to continue")
                                    .font(.caption)
                            }
                            .padding()
                            
                            ExtractedView()
                            
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
                        
                        
                        
                        Spacer()
                        
                        PrimaryButton(content: "Sign Up", maxWidth: 290, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(role: .Client)
    }
}

struct ExtractedView: View {
    @StateObject var registerVM = RegisterViewModel()
    var body: some View {
        VStack {
            LabelForm(content: registerVM.name, labeltext: "Names")
            LabelForm(content: registerVM.name, labeltext: "Email")
            LabelForm(content: registerVM.name, labeltext: "Password")
        }
        .padding()
    }
}
