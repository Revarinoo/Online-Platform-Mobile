//
//  PackageView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI

struct PackageView: View {
    
    var package: PackageResponse
    @State var typeDetail: String = ""
    @State var imageIcon: String = "photoIcon"
    
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(width: 53, height: 53)
            
            VStack (alignment: .leading) {
                Text("\(package.quantity) " + typeDetail)
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.black)
                Text(Int(package.price).setPriceFormat())
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .foregroundColor(Color.theme.primary)
            }
            .frame(width: 163, alignment: .leading)
            .padding(.leading, 12)
            
            Spacer()
        }
        .frame(width: 322, height: 53, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .onAppear {
            if package.type == "Photo" {
                typeDetail = " pcs photos"
                imageIcon = "photoIcon"
            }
            else if package.type == "Video" {
                typeDetail = " hours video"
                imageIcon = "videoIcon"
            }
            else if package.type == "Album" {
                typeDetail = " pages album"
                imageIcon = "albumIcon"
            }
        }
    }
}
