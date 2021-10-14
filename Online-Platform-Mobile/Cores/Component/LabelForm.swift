//
//  LabelForm.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/10/21.
//

import SwiftUI

struct LabelForm: View {
    
    @State var content: String = ""
    var labeltext: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labeltext)
                .foregroundColor(Color.gray)
            TextField("Enter Your \(labeltext)", text: $content)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10.0)
        }
    }
}

struct LabelForm_Previews: PreviewProvider {
    static var previews: some View {
        LabelForm(labeltext: "Name")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
