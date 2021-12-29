//
//  PackageListCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 26/12/21.
//

import SwiftUI

struct PackageListCard: View {
    
    var package: CreatePackageModel
    @State var imageIcon: String = "photoIcon"
    @State var typeDetail: String = ""
    
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(width: 53, height: 53)
            
            VStack (alignment: .leading) {
                Text("\(package.quantity) " + typeDetail)
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.black)
                Text(Int(package.price)!.setPriceFormat())
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .foregroundColor(Color.theme.primary)
            }
            .frame(width: 163, alignment: .leading)
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 18, bottom: 20, trailing: 18))
        .frame(width: 358, height: 93, alignment: .center)
        .cornerRadius(10)
        .onAppear {
            if package.type == "Photo" {
                imageIcon = "photoIcon"
                typeDetail = "pcs photos"
            }
            else if package.type == "Video" {
                imageIcon = "videoIcon"
                typeDetail = "hours videos"
            }
            else {
                imageIcon = "albumIcon"
                typeDetail = "pages album"
            }
        }
    }
}

struct PackageListCard_Previews: PreviewProvider {
    static var previews: some View {
        PackageListCard(package: CreatePackageModel())
    }
}
