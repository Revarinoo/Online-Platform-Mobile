//
//  PackageCard.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/11/21.
//

import SwiftUI

struct PackageCard: View {
    
    var package: ProductPackage
    @State var imageIcon: String = "photoIcon"
    @State var typeDetail: String = ""
    @State private var isClicked = false
    @Binding var carts: [ProductPackage]
    
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(width: 53, height: 53)
            
            VStack (alignment: .leading) {
                Text("\(package.quantity!) " + typeDetail)
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.black)
                Text(setPriceFormat(price: Int(package.price!)))
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .foregroundColor(Color.theme.primary)
            }
            .frame(width: 163, alignment: .leading)
            
            Button {
                self.isClicked = true
                carts.append(self.package)
            } label: {
                HStack (spacing: 3) {
                    Image(systemName: "plus")
                        .frame(width: 20, height: 20)
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .foregroundColor(.white)
                    Text("Add")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 6, leading: 13, bottom: 6, trailing: 13))
                .background(isClicked ? Color.theme.darkGrey : Color.theme.primary)
                .cornerRadius(10)
            }
            

        }
        .padding(EdgeInsets(top: 20, leading: 18, bottom: 20, trailing: 18))
        .frame(width: 358, height: 93, alignment: .center)
        .background(Color.theme.primarywhite)
        .cornerRadius(10)
        .onAppear {
            if package.type! == "Photo" {
                imageIcon = "photoIcon"
                typeDetail = "pcs photos"
            }
            else if package.type! == "Video" {
                imageIcon = "videoIcon"
                typeDetail = "hours videos"
            }
            else {
                imageIcon = "albumIcon"
                typeDetail = "pages album"
            }
        }
    }
    
    private func setPriceFormat(price: Int) -> String {
        if price == 0 {
            return "N/A"
        } else if price > 999999{
            return "\(String(format: "%g", Double(price)/1000000))M"
        } else if price > 999 {
            return "\(price/1000)K"
        } else {
            return "\(price)"
        }
    }
}

struct PackageCard_Previews: PreviewProvider {
    static var previews: some View {
        PackageCard(package: ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1), carts: .constant([]))
            .previewLayout(.sizeThatFits)
    }
}
