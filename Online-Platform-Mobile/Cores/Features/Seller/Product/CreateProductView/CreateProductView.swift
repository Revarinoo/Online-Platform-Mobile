//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 23/12/21.
//

import SwiftUI

struct CreateProductView: View {
    
    @StateObject var createproductVM: CreateProductViewModel = CreateProductViewModel()
    @State var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Product Information")
                    .bold()
                    .padding(.horizontal,30)
                VStack {
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker(selection: $createproductVM.selectedProduct) {
                            ForEach(0..<createproductVM.listProductCategory.count) {
                                Text(createproductVM.listProductCategory[$0])
                            }
                        } label: {
                            Text("Category")
                        }
                    }
                    .padding()
                    HStack {
                        Text("Product Information")
                        Spacer()
                        Picker(selection: $createproductVM.selectedProduct) {
                            ForEach(0..<createproductVM.listType.count) {
                                Text(createproductVM.listType[$0])
                            }
                        } label: {
                            Text("Type")
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                .padding(.horizontal)
                Text("Description")
                    .bold()
                    .padding(.horizontal,30)
                MultilineTextField(text: $createproductVM.desc)
                    .padding(.horizontal)
//                    .frame(height: 150)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarItems(trailing: Button("Save") {}
                                
            )
            .navigationBarTitle("Create Product", displayMode: .inline)
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView()
    }
}
