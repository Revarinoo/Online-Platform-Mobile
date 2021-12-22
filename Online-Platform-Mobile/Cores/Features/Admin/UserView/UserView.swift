//
//  UserView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 20/12/21.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var name: String = ""
}

struct UserView: View {
    
    @State private var searchText = ""
    
    private var itemList = [Item(name: "Andy is real"), Item(name: "Carla"), Item(name: "Mike"), Item(name: "Andy is not real")]
    
    var body: some View {
        
            ZStack {
                VStack {
                    SearchBar(text: $searchText)
                        .padding(.top)
                    VStack {
                        List(itemList.filter({ searchText.isEmpty ? true : $0.name
                                .contains(searchText)
                        })) { item in
                            Text(item.name)
                        }
                    }
                }
            }

        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
