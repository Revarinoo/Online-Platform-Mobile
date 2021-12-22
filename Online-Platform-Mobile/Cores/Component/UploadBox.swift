//
//  UploadBox.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 03/12/21.
//

import SwiftUI

struct UploadBox: View {
    
    @Binding var isShowingPhotoPicker: Bool
    @Binding var isUploaded: Bool
    var image: UIImage? = nil
    
    var body: some View {
        if isUploaded {
            HStack {
                Image(uiImage: (image ?? UIImage(systemName: "photo"))!)
                    .resizable()
                    .frame(width: 43, height: 36)
                    .foregroundColor(Color.black)
                Text("1 photo uploaded")
                    .foregroundColor(Color.black)
                Spacer()
                
            }
            .frame(maxWidth : .infinity, maxHeight: 20)
            .foregroundColor(Color.theme.darkGrey)
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.theme.darkGrey, style: StrokeStyle(lineWidth: 3, dash: [11]))
            )
        } else {
            Button ( action: {
                isShowingPhotoPicker = true
                
            }) {
                HStack {
                    Image(systemName: "icloud.and.arrow.up")
                    Text("Upload payment receipt")
                }
                .frame(maxWidth : .infinity, maxHeight: 20)
                .foregroundColor(Color.theme.darkGrey)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.theme.darkGrey, style: StrokeStyle(lineWidth: 3, dash: [11]))
                )
            }
        }
        
    }
}

struct UploadBox_Previews: PreviewProvider {
    static var previews: some View {
        UploadBox(isShowingPhotoPicker: .constant(false), isUploaded: .constant(false))
    }
}
