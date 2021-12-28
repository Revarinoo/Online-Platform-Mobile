//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 23/12/21.
//  Edited by Reva on 28/12/21.

import SwiftUI

struct CreateProductView: View {
    
    @StateObject private var createProductVM = SellerProductViewModel()
    @Binding var showPage: Bool
    @State var showPicker = false
    var listProductCategory = ["Choose", "Birthday", "Family", "Graduation", "Travel", "Newborn", "Wedding"]
    
    var body: some View {
        NavigationView {
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
                Spacer()
            }
            .sheet(isPresented: $showPicker, content: {
                ImagePickerReferences(referenceImages: $createProductVM.product.portfolios)
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showPage.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createProductVM.createProduct()
                    } label: {
                        Text("Save")
                    }
                }
            })
            .navigationBarTitle("Create Product", displayMode: .inline)
        }
        .onChange(of: createProductVM.successfullyCreated) { _ in
            self.showPage = false
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView(showPage: .constant(true))
    }
}
