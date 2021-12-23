//
//  WelcomeView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/10/21.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView{
            ZStack {
                
                Image("welcomepage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .brightness(-0.05)
                
                VStack {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(maxHeight: 300)
                        
                        VStack (alignment: .leading){
                            Text("Graf") // App Name
                                .font(.largeTitle)
                                .bold()
                        }
                        .foregroundColor(Color.theme.primarywhite)
                        .padding(.vertical)
                        
                        // Find Service Nav Link
                        NavigationLink(destination: RegisterView()
                        ) {
                            Text("Find a Service")
                                .frame(minWidth: 0, maxWidth: 300)
                                .padding()
                                .foregroundColor(Color.theme.primarywhite)
                                .background(Color.theme.tertiary)
                                .cornerRadius(15)
                                .font(.title3)
                        }
                        .navigationTitle("")
                        
                        // Become Seller Nav Link
                        NavigationLink(destination: RegisterView()) {
                            Text("Become a Seller")
                                .frame(minWidth: 0, maxWidth: 300)
                                .foregroundColor(Color.theme.primarywhite)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.theme.primarywhite, lineWidth: 2)
                                )
                                .font(.title3)
                        }
                        .navigationTitle("")
                    }
                    
                    VStack {
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(Color.theme.primarywhite)
                            NavigationLink(
                                destination: LoginView(selection: .Client),
                                label: {
                                    Text("Sign In")
                                        .bold()
                                        .foregroundColor(Color.theme.primarywhite)
                                })
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
