//
//  ProductListView.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 22/12/21.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var searchText = ""
    
    @State private var itemList = [Item(name: "Andy is real"), Item(name: "Carla"), Item(name: "Mike"), Item(name: "Andy is not real")]
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(itemList.filter({ searchText.isEmpty ? true : $0.name.contains(searchText)
                        }), id: \.id) { item in
                            Text(item.name)
                        }
                        .onDelete(perform: self.deleteRow)
                    }
                }
            }
        .navigationTitle("Product List")
        .listStyle(PlainListStyle())
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.itemList.remove(atOffsets: indexSet)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}