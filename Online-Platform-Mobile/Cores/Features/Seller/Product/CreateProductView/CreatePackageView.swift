//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import SwiftUI

struct CreatePackageView: View {
    
    @StateObject var createPackageVM: SellerProductViewModel
    var listType = ["Photo", "Video", "Album"]
    @Binding var showCreatePackage: Bool
    @State private var showEmpty = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Product Information")) {
                        Picker(selection: $createPackageVM.package.type) {
                            ForEach(listType, id: \.self) {
                                Text($0)
                            }
                        } label: {
                            Text("Category")
                        }
                        TextField("Package Price", text: $createPackageVM.package.price)
                            .keyboardType(.decimalPad)
                    }
                    
                    if createPackageVM.package.type == "Photo" {
                        Section(header: Text("Package Detail")) {
                            Stepper("Photo Amount (\(createPackageVM.package.quantity))") {
                                createPackageVM.package.quantity += 5
                            } onDecrement: {
                                createPackageVM.package.quantity -= 5
                            }
                            
                            Toggle(isOn: $createPackageVM.package.highResolution) {
                                Text("High Resolution")
                            }
                            Toggle(isOn: $createPackageVM.package.sourceFile) {
                                Text("Source File")
                            }
                            Toggle(isOn: $createPackageVM.package.commercial) {
                                Text("Commercial Use")
                            }
                            Toggle(isOn: $createPackageVM.package.editing) {
                                Text("Lighting Editing")
                            }
                            Stepper("Revision Amount (\(createPackageVM.package.revision))") {
                                createPackageVM.package.revision += 1
                            } onDecrement: {
                                if createPackageVM.package.revision - 1 >= 0 {
                                    createPackageVM.package.revision -= 1
                                }
                            }
                        }
                    }
                    
                    else if createPackageVM.package.type == "Video" {
                        Section(header: Text("Package Detail")) {
                            Stepper("Video Amount (\(createPackageVM.package.quantity))") {
                                createPackageVM.package.quantity += 1
                            } onDecrement: {
                                if createPackageVM.package.quantity - 1 >= 0 {
                                    createPackageVM.package.quantity -= 1
                                }
                            }
                            
                            Stepper("Revision Amount (\(createPackageVM.package.revision))") {
                                createPackageVM.package.revision += 1
                            } onDecrement: {
                                if createPackageVM.package.revision - 1 >= 0 {
                                    createPackageVM.package.revision -= 1
                                }
                            }
                        }
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showCreatePackage.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if createPackageVM.validatePackage() {
                                createPackageVM.allPackage.append(createPackageVM.package)
                                createPackageVM.package.reset()
                                showCreatePackage.toggle()
                            }
                            else {
                                showEmpty.toggle()
                            }
                        } label: {
                            Text("Save")
                        }
                    }
                })
                .navigationBarTitle("Create Package", displayMode: .inline)
                
            }
        }
        .alert(isPresented: $showEmpty, content: {
            Alert(title: Text("Failed"), message: Text("All field must be filled"), dismissButton: .default(Text("OK")))
        })
    }
}

struct CreatePackageView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePackageView(createPackageVM: SellerProductViewModel(), showCreatePackage: .constant(true))
    }
}
