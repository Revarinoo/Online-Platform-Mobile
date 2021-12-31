//
//  TransactionList.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 31/12/21.
//

import SwiftUI

struct TransactionListView: View {
    @State private var searchText = ""
    @StateObject private var transactionVM = TransactionViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(transactionVM.transactions.filter({ searchText.isEmpty ? true : $0.user.contains(searchText)
                        }), id: \.id) { item in
                            NavigationLink(destination: TransactionDetailView(transaction: item, transactionVM: transactionVM)) {
                                Text(item.user)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                transactionVM.getTransactions()
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
