//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import SwiftUI

struct CreatePackageView: View {
    
    @StateObject private var createPackageVM = CreatePackageViewModel()
    @State var selectedIndex = 0
    var listType = ["Photo", "Video", "Album"]
    
    var body: some View {
            VStack {
                Form {
                    Section(header: Text("Product Information")) {
                        Picker(selection: $createPackageVM.package.type) {
                            ForEach(0..<listType.count) {
                                Text(listType[$0])
                            }
                        } label: {
                            Text("Category")
                        }
                        TextField("Package Price", value: $createPackageVM.package.price, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
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
                .navigationBarItems(trailing:
                                        Button("Save") {
                    
                }
                )
                .navigationBarTitle("Create Package", displayMode: .inline)
            }
    }
}

struct CreatePackageView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePackageView()
    }
}
