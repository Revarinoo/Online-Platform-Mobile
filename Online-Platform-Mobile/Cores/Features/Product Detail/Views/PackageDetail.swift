//
//  PackageDetail.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 16/11/21.
//

import SwiftUI

struct PackageDetail: View {
    
    var package: ProductPackage
    @State var typeDetail = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 18) {
            Text("Package Detail")
                .font(.custom(ThemeFont.displaySemiBold, size: 18))
            
            VStack (alignment: .leading, spacing: 12) {
                PackageContent(icon: 1, content: "\(package.quantity!) \(typeDetail)")
                PackageContent(icon: package.high_resolution!, content: "High Resolution")
                PackageContent(icon: package.source_file!, content: "Source File")
                PackageContent(icon: package.commercial_use!, content: "Commercial Use")
                PackageContent(icon: package.light_editing!, content: "Light Editing")
                PackageContent(icon: 1, content: "\(package.revision!)x Revision")
            }
            
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 16)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .navigationBarTitle("\(package.quantity!) \(typeDetail)", displayMode: .inline)
        .navigationBackButton(color: UIColor(Color.theme.primary))
        .onAppear {
            if package.type! == "Photo" {
                typeDetail = "pcs photos"
            }
            else if package.type! == "Video" {
                typeDetail = "hours videos"
            }
            else {
                typeDetail = "pages album"
            }
        }
    }
}

struct PackageDetail_Previews: PreviewProvider {
    static var previews: some View {
        PackageDetail(package: ProductPackage(id: 1, price: 300000, revision: 1, quantity: 100, type: "Photo", high_resolution: 1, source_file: 1, commercial_use: 1, light_editing: 1))
    }
}


struct PackageContent: View {
    var icon: Int
    var content: String
    
    var body: some View {
        HStack (spacing: 6) {
            Image(systemName: icon == 1 ? "checkmark.circle" : "x.circle")
                .resizable()
                .foregroundColor(Color.theme.primary)
                .scaledToFit()
                .frame(width: 22, height: 21)
            
            Text(content)
                .font(.custom(ThemeFont.displayRegular, size: 18))
                .foregroundColor(.black)
        }
    }
}
