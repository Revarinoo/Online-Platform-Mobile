//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 23/12/21.
//  Edited by Reva on 28/12/21.

import SwiftUI
import Introspect

struct CreateProductView: View {
    
    @StateObject private var createProductVM = SellerProductViewModel()
    @Binding var showPage: Bool
    @State var showPicker = false
    var listProductCategory = ["Choose", "Birthday", "Family", "Graduation", "Travel", "Newborn", "Wedding"]
    @State var showCreatePackage = false
    var productId: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showLoading = false
    
    var body: some View {
        if productId == nil {
            NavigationView {
                content
            }
        }
        else {
            content
        }
        
    }
    
    var content: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Product Information")
                        .bold()
                        .padding(.horizontal,30)
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker(selection: $createProductVM.product.category) {
                            ForEach(listProductCategory, id: \.self) {
                                Text($0)
                            }
                        } label: {
                            Text("Category")
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                    .padding(.horizontal)
                    Text("Description")
                        .bold()
                        .padding(.horizontal,30)
                    MultilineTextField(text: $createProductVM.product.description)
                        .introspectTextField(customize: { textField in
                            textField.resignFirstResponder()
                        })
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                        .padding(.horizontal)
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Portfolio")
                                .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                .foregroundColor(.black)
                            Text("(max. 5 photos)")
                                .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                .foregroundColor(Color.theme.darkGrey)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                if createProductVM.product.portfolios.count == 0 {
                                    Image(systemName: "camera")
                                        .font(.system(size: 24))
                                        .foregroundColor(.gray)
                                        .scaledToFill()
                                        .frame(width: 82, height: 88)
                                        .background(Color.init(hex: "F3F4F8"))
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            self.showPicker.toggle()
                                        }
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 24))
                                        .foregroundColor(.gray)
                                        .scaledToFill()
                                        .frame(width: 82, height: 88)
                                        .background(Color.init(hex: "F3F4F8"))
                                        .cornerRadius(10)
                                }
                                else {
                                    ForEach(createProductVM.product.portfolios, id:\.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 82, height: 88)
                                            .background(Color.init(hex: "F3F4F8"))
                                            .cornerRadius(10.0)
                                    }
                                    if createProductVM.product.portfolios.count < 5 {
                                        Image(systemName: "plus")
                                            .font(.system(size: 24))
                                            .foregroundColor(.gray)
                                            .scaledToFill()
                                            .frame(width: 82, height: 88)
                                            .background(Color.init(hex: "F3F4F8"))
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.showPicker.toggle()
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 16)
                    .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Text("Package List")
                                .bold()
                                .padding(.horizontal,30)
                            Spacer()
                            Button {
                                showCreatePackage.toggle()
                            } label: {
                                Label("Add New", systemImage: "plus")
                                    .font(.caption)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical,5)
                        ForEach(createProductVM.allPackage) { package in
                            PackageListCard(package: package)
                                .frame(width: 358, height: 95)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $showPicker, content: {
                    ImagePickerReferences(referenceImages: $createProductVM.product.portfolios)
                })
                .sheet(isPresented: $showCreatePackage, content: {
                    CreatePackageView(createPackageVM: createProductVM, showCreatePackage: $showCreatePackage)
                })
                .alert(isPresented: $createProductVM.showEmpty, content: {
                    Alert(title: Text("Failed"), message: Text("All field must be filled"), dismissButton: .default(Text("OK")))
                })
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.showPage.toggle()
                        } label: {
                            Text(productId == nil ? "Cancel" : "")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showLoading.toggle()
                            if productId == nil {
                                createProductVM.createProduct()
                            }
                            else {
                                createProductVM.updateProduct(productId: productId!)
                            }
                        } label: {
                            Text("Save")
                        }
                    }
                })
                .navigationBarTitle(productId == nil ? "Create Product" : "Edit Product", displayMode: .inline)
            }
            .onChange(of: createProductVM.successfullyCreated) { _ in
                self.showPage = false
                self.showLoading = false
                if productId != nil {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .onTapGesture {
                self.dismissKeyboard()
            }
            .onAppear {
                if productId != nil {
                    createProductVM.getSellerProductDetail(productId: productId!)
                }
            }
            if showLoading {
                LoadingView()
            }
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView(showPage: .constant(true))
    }
}
