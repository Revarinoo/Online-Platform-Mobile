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
    @State var showCreatePackage = false
    var productId: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showLoading = false
    @State var uiTabBarController: UITabBarController?
    @State private var isEditing = true
    @State private var loadData = true
    var productVM: MyProductViewModel
    
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
                            Text("Choose")
                            ForEach(createProductVM.categories, id: \.self) {
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
                    
                    TextArea(text: $createProductVM.product.description, placeholder: "Write your product description here", isEditing: $isEditing, height: 154)
                        .padding(.leading, 16)
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
                                        ZStack {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 82, height: 88)
                                                .background(Color.init(hex: "F3F4F8"))
                                            .cornerRadius(10.0)
                                            
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Button {
                                                        if let index = createProductVM.product.portfolios.firstIndex(of: image) {
                                                            createProductVM.product.portfolios.remove(at: index)
                                                        }
                                                    } label: {
                                                        Image("xButton")
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 20, height: 20)
                                                            .padding(.trailing, -5)
                                                    }
                                                }
                                                Spacer()
                                            }
                                        }
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
                productVM.getAllProduct()
            }
            .onTapGesture {
                self.isEditing = false
                self.dismissKeyboard()
            }
            .onAppear {
                createProductVM.getCategories()
                if productId != nil {
                    createProductVM.getSellerProductDetail(productId: productId!)
                }
            }
            .introspectTabBarController { UITabBarController in
                UITabBarController.tabBar.isHidden = true
                uiTabBarController = UITabBarController
            }
            .fullScreenCover(isPresented: $showLoading) {
                LoadingView()
            }
            if productId != nil && loadData {
               LoadingView()
                   .onChange(of: createProductVM.finishLoad) { _ in
                       loadData = false
                   }
           }
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView(showPage: .constant(true), productVM: MyProductViewModel())
    }
}
