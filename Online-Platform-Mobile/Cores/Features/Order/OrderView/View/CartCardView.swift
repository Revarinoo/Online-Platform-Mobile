//
//  CartCardView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/11/21.
//

import SwiftUI

struct CartCardView: View {
    
    var package: ProductPackage
    @Binding var carts: [ProductPackage]
    var type: String
    @State var typeDetail: String = ""
    @State var imageIcon: String = "photoIcon"
    
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(width: 53, height: 53)
            
            VStack (alignment: .leading) {
                Text("\(package.quantity!) " + typeDetail)
                    .font(.custom(ThemeFont.displayRegular, size: 18))
                    .foregroundColor(Color.black)
                Text(Int(package.price!).setPriceFormat())
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .foregroundColor(Color.theme.primary)
            }
            .frame(width: 163, alignment: .leading)
            .padding(.leading, 12)
            
            Spacer()
            Button {
                if let index = carts.firstIndex(of: package) {
                    carts.remove(at: index)
                }
            } label: {
                Text("Remove")
                    .font(.custom(ThemeFont.displayRegular, size: 13.5))
                    .foregroundColor(.red)
            }

        }
        .frame(width: 322, height: 53, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .onAppear {
            if type == "Photo" {
                typeDetail = " pcs photos"
                imageIcon = "photoIcon"
            }
            else if type == "Video" {
                typeDetail = " hours video"
                imageIcon = "videoIcon"
            }
            else if type == "Album" {
                typeDetail = " pages album"
                imageIcon = "albumIcon"
            }
        }
    }
}

struct CartCardView_Previews: PreviewProvider {
    static var previews: some View {
        CartCardView(package: ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1), carts: .constant([]), type: "Video")
            .previewLayout(.sizeThatFits)
    }
}
