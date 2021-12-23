//
//  AddCategoryView.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 23/12/21.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State private var categoryName: String = ""
    
    var body: some View {
        VStack (alignment: .leading){
            HStack(alignment: .center) {
                Spacer()
                VStack{
                    ZStack{
                        Image(systemName: "camera").font(.system(size: 36)).foregroundColor(Color.theme.darkGrey).scaledToFill().frame(width: 127, height: 127)
                            .background(Color.gray.opacity(0.1))
                                .cornerRadius(20.0)
                                .overlay(RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color.white, lineWidth: 5))
                    }
                    Text("Add Category Icon")
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
                .navigationTitle("Add Category")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Cancel")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("Save")
                    }
                }
        }
        .padding()
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
