//
//  UserView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 20/12/21.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    var id = UUID()
    var name: String = ""
}

struct UserView: View {
    
    @State private var searchText = ""
    
    @State private var itemList = [Item(name: "Andy is real"), Item(name: "Carla"), Item(name: "Mike"), Item(name: "Andy is not real")]
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    SearchBar(text: $searchText)
                    VStack {
                        List{
                            ForEach(itemList.filter({ searchText.isEmpty ? true : $0.name.contains(searchText)
                            }), id: \.id) { item in
                                NavigationLink(destination: ProductListView()) {
                                    Text(item.name)
                                }
                            }
                            .onDelete(perform: self.deleteRow)
                        }
                    }
                }
            }
            .navigationTitle("User List")
            .listStyle(PlainListStyle())
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.itemList.remove(atOffsets: indexSet)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
