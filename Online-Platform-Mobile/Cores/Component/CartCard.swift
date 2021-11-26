//
//  CartCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 17/11/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct CartCard: View {
    
    //var image: String
    @State var name: String
    @State var desc: String
    @State var type: String
    @Binding var cart: [ProductPackage]
    @State var index: Int

    
    
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 53, height: 53)
                switch type{
                case "Photo":
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                case "Video":
                    Image(systemName: "video")
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                case "Disc":
                    Image(systemName: "tag")
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                case "Loc":
                    Image(systemName: "location")
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                default:
                    WebImage(url: URL(string: ""))
                        .resizable()
                        .frame(width: 34, height: 28)
                        .foregroundColor(Color.theme.primarywhite)
                }
                
                
            }
            VStack (alignment: .leading, spacing: 3) {
                Text("\(index)")
                    .foregroundColor(Color.black)
                    .fontWeight(.medium)
                if type != "Disc" {
                    if type == "Loc" {
                        Text(desc)
                            .font(.caption)
                            .foregroundColor(Color.theme.primary)
                    } else {
                        Text(desc)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.primary)
                    }
                }
            }
            Spacer()
            if type == "pack" {
                Text("Remove")
                    .foregroundColor(Color.red)
                    .font(.caption)
                    .onTapGesture {
                        print("debug1 \(cart.count)")
                        print("debug1 index: \(index)")
//                        cart.remove(at: index)
                        cart.append(ProductPackage(id: 0, price: 0, revision: 0, quantity: 0, type: "", high_resolution: 0, source_file: 0, commercial_use: 0, light_editing: 0))
                    }
                
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(Color.theme.darkGrey)
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
        
    }
}

struct CartCard_Previews: PreviewProvider {
    static var previews: some View {
        CartCard(name: "Rumah Bandung", desc: "21, Jalan Jingganegara", type: "Photo", cart: .constant([]), index: 1)
            .padding()
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            .previewLayout(.sizeThatFits)
        
        CartCard(name: "Rumah Bandung", desc: "500K", type: "Video", cart: .constant([]), index: 2)
            .padding()
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            .previewLayout(.sizeThatFits)
    }
}
