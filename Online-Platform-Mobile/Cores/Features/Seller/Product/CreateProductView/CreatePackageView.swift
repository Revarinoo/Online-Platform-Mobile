//
//  CreateProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/12/21.
//

import SwiftUI

struct CreatePackageView: View {
    
    @StateObject var createproductVM: CreateProductViewModel = CreateProductViewModel()
    @State var selectedIndex = 0
    
    var body: some View {
            VStack {
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
                    
                    if createproductVM.selectedIndex == 0 {
                        Section(header: Text("Package Detail")) {
                            Stepper("Photo Amount (\(createproductVM.photoamount))") {
                                createproductVM.photoamount += 5
                            } onDecrement: {
                                createproductVM.photoamount -= 5
                            }
                            
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
                            Stepper("Revision Amount (\(createproductVM.revisionAmount))") {
                                createproductVM.revisionAmount += 5
                            } onDecrement: {
                                createproductVM.revisionAmount -= 5
                            }
                        }
                    }
                    
                    if createproductVM.selectedIndex == 1 {
                        Section(header: Text("Package Detail")) {
                            Stepper("Video Amount (\(createproductVM.videoduration))") {
                                createproductVM.videoduration += 1
                            } onDecrement: {
                                createproductVM.videoduration -= 1
                            }
                            
                            Toggle(isOn: $createproductVM.highresolution) {
                                Text("Revision")
                            }
                            Stepper("Revision Amount (\(createproductVM.revisionAmount))") {
                                createproductVM.revisionAmount += 1
                            } onDecrement: {
                                createproductVM.revisionAmount -= 1
                            }
                        }
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
                .navigationBarTitle("Create Package", displayMode: .inline)
            }
    }
}

struct CreatePackageView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePackageView()
    }
}
