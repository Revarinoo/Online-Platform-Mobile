//
//  AddCategoryView.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 23/12/21.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State private var categoryName: String = ""
    @State private var showPicker = false
    @State private var image: UIImage = UIImage()
    @Binding var showPage: Bool
    var categoryVM: CategoryViewModel
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                HStack(alignment: .center) {
                    Spacer()
                    VStack{
                        ZStack{
                            Image(uiImage: image == UIImage() ? UIImage(named: "cam")! : image)
                                .resizable()
                                .frame(width: image == UIImage() ? 46 : 127, height: image == UIImage() ? 36 : 127)
                                .scaledToFill()
                                .frame(width: 127, height: 127)
                                .font(.system(size: 36))
                                .foregroundColor(Color.theme.darkGrey).scaledToFill().frame(width: 127, height: 127)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20.0)
                                .overlay(RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color.white, lineWidth: 5))
                                .onTapGesture {
                                    self.showPicker.toggle()
                                }
                        }
                        Text("Add Category Icon")
                            .font(.custom(ThemeFont.displayMedium, size: 15))
                            .foregroundColor(Color.theme.darkGrey)
                    }
                    Spacer()
                }
                .padding(.bottom, 17)
                Text("Category Name")
                    .foregroundColor(Color.theme.darkGrey)
                    .font(.custom(ThemeFont.displayMedium, size: 13.5))
                TextField("Enter Category Name", text: $categoryName)
                    .textFieldStyle(OvalTextFieldStyle())
                    Spacer()
                    
                    
            }
            .padding()
            .sheet(isPresented: $showPicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showPage.toggle()
                    } label: {
                        Text("Cancel")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        categoryVM.createCategory(categoryName: self.categoryName, icon: self.image)
                    } label: {
                        Text("Save")
                    }
                    .disabled(categoryName == "" || image == UIImage() ? true : false)
                    .opacity(categoryName == "" || image == UIImage() ? 0.4 : 1)
                }
            }
            .onChange(of: categoryVM.successfullyCreated) { newValue in
                self.showPage = false
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(showPage: .constant(true), categoryVM: CategoryViewModel())
    }
}
