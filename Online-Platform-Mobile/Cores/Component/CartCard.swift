//
//  CartCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 17/11/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct CartCard: View {
    
    @State var name: String
    @State var desc: String
    @State var type: String

    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 53, height: 53)
                switch type{
                case "Disc":
                    Image("tag")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22.42, height: 24.91)
                        .foregroundColor(Color.theme.primarywhite)
                case "Loc":
                    Image("loc")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 19.5, height: 23.69)
                        .foregroundColor(Color.theme.primarywhite)
                default:
                    WebImage(url: URL(string: ""))
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                }
            }
            VStack (alignment: .leading, spacing: 3) {
                Text("\(name)")
                    .font(.custom(ThemeFont.displayMedium, size: 18))
                    .foregroundColor(Color.black)
                if type == "Loc" {
                    Text(desc)
                        .font(.custom(ThemeFont.displayRegular, size: 13.5))
                        .foregroundColor(Color.theme.primary)
                }
            }
            Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(Color.theme.darkGrey)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
        
    }
}

struct CartCard_Previews: PreviewProvider {
    static var previews: some View {
        CartCard(name: "Rumah Bandung", desc: "21, Jalan Jingganegara", type: "Loc")
            .padding()
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            .previewLayout(.sizeThatFits)
        
        CartCard(name: "1 discount is applied", desc: "500K", type: "Disc")
            .padding()
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            .previewLayout(.sizeThatFits)
    }
}
