////
////  EditProduct.swift
////  Online-Platform-Mobile
////
////  Created by Christian Adiputra on 26/12/21.
////
//
//import SwiftUI
//
//struct EditProduct: View {
//
//    @StateObject private var productVM = SellerProductViewModel()
//    @State var selectedIndex = 0
//
//
//    var body: some View {
//            VStack(alignment: .leading) {
//                Text("Product Information")
//                    .bold()
//                    .padding(.horizontal,30)
//                VStack {
//                    HStack {
//                        Text("Category")
//                        Spacer()
//                        Picker(selection: $createproductVM.selectedProduct) {
//                            ForEach(0..<createproductVM.listProductCategory.count) {
//                                Text(createproductVM.listProductCategory[$0])
//                            }
//                        } label: {
//                            Text("Category")
//                        }
//                    }
//                    .padding()
//                    HStack {
//                        Text("Product Information")
//                        Spacer()
//                        Picker(selection: $createproductVM.selectedProduct) {
//                            ForEach(0..<createproductVM.listType.count) {
//                                Text(createproductVM.listType[$0])
//                            }
//                        } label: {
//                            Text("Type")
//                        }
//                    }
//                    .padding()
//                }
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
//                .padding(.horizontal)
//
//                VStack(alignment: .leading) {
//                    Text("Description")
//                        .bold()
//                        .padding(.horizontal,30)
//                        .padding(.vertical,5)
//                    MultilineTextField(text: $createproductVM.desc)
//                        .padding(.horizontal)
//                        .frame(height: 80)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
//                        .padding(.horizontal)
//                }
//
//                VStack {
//                    HStack {
//                        Text("Package List")
//                            .bold()
//                            .padding(.horizontal,30)
//                        Spacer()
//                        NavigationLink(destination: CreatePackageView()) {
//                            Label("Add New", systemImage: "plus")
//                                .font(.caption)
//                                .padding(.horizontal)
//                        }
//
//                    }
//                    .padding(.vertical,5)
//                    ForEach(1..<3) { _ in
//                        PackageListCard()
//                            .frame(width: 358, height: 95)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
//                    }
//                }
//
//
//                Spacer()
//            }
//            .navigationBarItems(trailing: Button("Save") {}
//
//            )
//            .navigationBarTitle("Create Product", displayMode: .inline)
//    }
//}
//
//struct EditProduct_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProduct()
//    }
//}
