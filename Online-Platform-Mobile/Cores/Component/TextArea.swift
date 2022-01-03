//
//  TextArea.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import SwiftUI
import TextView

struct TextArea: View {
    @Binding var text: String
    var placeholder: String
    @Binding var isEditing: Bool
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        TextView(
            text: $text,
            isEditing: $isEditing,
            placeholder: self.placeholder
        )
            .padding([.top, .leading], 18)
            .frame(width: self.width != nil ? width! : 358, height: self.height != nil ? height! : 178)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 5, x: 1, y: 4)
    }
}
