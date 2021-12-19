//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import SwiftUI

struct CreateProductView: View {
    
    @StateObject var createproductVM: CreateProductViewModel = CreateProductViewModel()
    @State var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Package Name ", text: $createproductVM.packageName)
                    Picker(selection: $createproductVM.selectedIndex) {
                        ForEach(0..<createproductVM.listCategory.count) {
                            Text(createproductVM.listCategory[$0])
                        }
                    } label: {
                        Text("Category")
                    }
                    TextField("Package Price ", text: $createproductVM.packagePrice)
                }
                
                
                Section(header: Text("Product Detail")) {
                    TextField("Package Name ", text: $createproductVM.packageName)
                    Toggle(isOn: $createproductVM.highresolution) {
                        Text("High Resolution")
                    }
                    Toggle(isOn: $createproductVM.sourcefile) {
                        Text("Source File")
                    }
                    Toggle(isOn: $createproductVM.commercialuse) {
                        Text("Commercial Use")
                    }
                    Toggle(isOn: $createproductVM.fullediting) {
                        Text("Full Editing")
                    }
                    Toggle(isOn: $createproductVM.lightediting) {
                        Text("Lighting Editing")
                    }
                    Toggle(isOn: $createproductVM.revision) {
                        Text("Revision")
                    }
                    Picker(selection: $createproductVM.selectedIndex) {
                        ForEach(0..<createproductVM.listCategory.count) {
                            Text(createproductVM.listCategory[$0])
                        }
                    } label: {
                        Text("Category")
                    }
                    TextField("Revision Amount", text: $createproductVM.packagePrice)
                }
            }
            .navigationBarItems(trailing:
                Button("Save") {
                print(createproductVM.packageName)
                print(createproductVM.packageCategory)
                print(createproductVM.highresolution)
                print(createproductVM.sourcefile)
                print(createproductVM.commercialuse)
                print(createproductVM.fullediting)
                print(createproductVM.fullediting)
                print("X")
                }
            )
            .navigationBarTitle("Create Product", displayMode: .inline)
            //            .padding(.horizontal)
            //            .background(Color.white)
            //            .cornerRadius(10)
            //            .shadow(color: Color.gray.opacity(0.4), radius: 3)
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView()
    }
}
