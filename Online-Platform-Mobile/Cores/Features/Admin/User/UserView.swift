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
    @StateObject private var listUserVM = ListUserViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(listUserVM.users.filter({ searchText.isEmpty ? true : $0.name.contains(searchText)
                        }), id: \.id) { item in
                            NavigationLink(destination: ProductListView(userId: item.id)) {
                                Text(item.name)
                            }
                        }
                        .onDelete(perform: self.deleteRow)
                    }
                }
            }
            .onAppear {
                listUserVM.getAllUser()
            }
        }
        
    }
    private func deleteRow(at indexSet: IndexSet) {
        if let index = indexSet.first {
            self.listUserVM.removeUser(userId: listUserVM.users[index].id)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
