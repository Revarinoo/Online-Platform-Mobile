//
//  ProductListView.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 22/12/21.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var searchText = ""
    @StateObject private var productVM = AdminProductViewModel()
    var userId: Int
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(productVM.products.data.filter({ searchText.isEmpty ? true : $0.category.contains(searchText)
                        }), id: \.id) { item in
                            NavigationLink(destination: PortfolioListView(productId: item.id, category: item.category, productVM: productVM, userId: userId)) {
                                HStack {
                                    Text(item.category)
                                    if item.status == "Did not match" {
                                        Spacer()
                                        Image(systemName: "exclamationmark.triangle")
                                            .foregroundColor(Color.red)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: self.deleteRow)
                    }
                }
            }
        .navigationTitle("Product List")
        .listStyle(PlainListStyle())
        }
        .onAppear {
            productVM.getAllSellerProduct(userId: self.userId)
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        let id = productVM.products.data[indexSet.first!].id
        productVM.removeProduct(productId: id, userId: self.userId)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(userId: 1)
    }
}
