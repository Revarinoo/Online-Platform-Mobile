//
//  EditProfileView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showImagePicker = false
    @Binding var showThisPage: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack (spacing: 18) {
                        VStack {
                            Image(uiImage: viewModel.profile.photo == UIImage() ? UIImage(named: "cam")! : viewModel.profile.photo)
                                .resizable()
                                .frame(width: viewModel.profile.photo == UIImage() ? 46 : 127, height: viewModel.profile.photo == UIImage() ? 36 : 127)
                                .foregroundColor(.gray)
                                .scaledToFill()
                                .frame(width: 127, height: 127)
                                .background(Color.init(hex: "F3F4F8"))
                                .cornerRadius(20)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 5))
                                .onTapGesture {
                                    showImagePicker.toggle()
                                }
                            Text(viewModel.profile.photo == UIImage() ? "Add Photo" : "Change Photo")
                                .font(.custom(ThemeFont.displayRegular, size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 30)
                        EditProfileForm(profile: $viewModel.profile)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.profile.photo)
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showThisPage.toggle()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color.theme.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.editProfile()
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.theme.primary)
                    }
                }
            }
        }
        .onChange(of: viewModel.isFinishedUploading) { _ in
            self.showThisPage = false
            UserHelper.shared.getUserData()
        }
        .alert(isPresented: $viewModel.redBanner, content: {
            Alert(title: Text("Failed"), message: Text(viewModel.failedMessage == "" ? "All field must be filled" : viewModel.failedMessage), dismissButton: .default(Text("OK")))
        })
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showThisPage: .constant(true))
    }
}
