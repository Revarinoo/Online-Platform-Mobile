//
//  ComplainListView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import SwiftUI
import Introspect

struct ComplainListView: View {
    @StateObject private var complainVM = AdminComplainViewModel()
    @State private var searchText = ""
    @State var uiTabBarController: UITabBarController?
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(complainVM.complains.filter({ searchText.isEmpty ? true : $0.client_name.contains(searchText)
                        }), id: \.id) { item in
                            NavigationLink(destination: ComplainDetailView(vm: complainVM, id: item.id, model: item)) {
                            Text(item.client_name)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                complainVM.getComplains()
            }
        }
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = false
            uiTabBarController = UITabBarController
        }
    }
}

struct ComplainListView_Previews: PreviewProvider {
    static var previews: some View {
        ComplainListView()
    }
}
