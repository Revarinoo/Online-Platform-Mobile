//
//  CustomPicker.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 20/10/21.
//

import SwiftUI

struct CustomPicker: View {
    
    @Binding var selection: Role
    var isLogin: Bool
    
    var body: some View {
        Menu {
            Picker ( selection: $selection, label: EmptyView()) {
                ForEach(Role.allCases, id: \.self) {
                    if isLogin || $0.rawValue != "Admin" {
                        Text($0.rawValue)
                            .tag($0.rawValue)
                    }
                }
                .frame(width: 200)
            }
            .labelsHidden()
            .pickerStyle(InlinePickerStyle())
        } label: {
            HStack{
                Text(selection.rawValue)
                    .padding(.leading,20)
                Spacer()
                Image(systemName: "chevron.down")
                    .padding(.trailing,10)
            }
            .font(.headline)
            .accentColor(Color.theme.primary)
            .frame(maxWidth: .infinity, maxHeight: 45)
            .padding(.vertical, 5)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        
    }
}




struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(selection: .constant(.Client), isLogin: false)
    }
}
