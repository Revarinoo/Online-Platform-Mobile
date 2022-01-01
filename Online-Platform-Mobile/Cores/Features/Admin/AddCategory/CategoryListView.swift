//
//  CategoryListView.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 22/12/21.
//

import SwiftUI

struct CategoryListView: View {
    
    @State private var searchText = ""
    @State var showAddCategory = false
    @StateObject private var categoryVM = CategoryViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                SearchBar(text: $searchText)
                VStack {
                    List{
                        ForEach(categoryVM.categories.filter({ searchText.isEmpty ? true : $0.name!.contains(searchText)
                        }), id: \.category_id) { item in
                            Text(item.name!)
                        }
                        .onDelete(perform: self.deleteRow)
                    }
                }
            }
        }
        .navigationTitle("Category List")
        .toolbar(content: {
            Button {
                showAddCategory.toggle()
            } label: {
                Text("Add Category")
            }

        })
        .listStyle(PlainListStyle())
        .sheet(isPresented: $showAddCategory) {
            AddCategoryView(showPage: self.$showAddCategory, categoryVM: categoryVM)
        }
        .onAppear {
            categoryVM.getCategories()
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        categoryVM.removeCategory(id: categoryVM.categories[indexSet.first!].category_id!)
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
