//
//  LocationCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 05/12/21.
//

import SwiftUI

struct LocationCard: View {
    
    @State var addressname = "Rumah Bandung"
    @State var recivername = "Kenneth Jonathan"
    @State var phone = "6282398222982"
    @State var address = "Taman Kopo Indah, Jl. Clover III No 5 Kopo, Bandung, Jawa Barat"
    @State var postalcode = "40355"
    
    var body: some View {
        HStack {
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .fill(Color.theme.primary)
                        .frame(width: 53, height: 53)
                    Image(systemName: "mappin.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.theme.primarywhite)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(addressname)
                    Text(recivername)
                        .fontWeight(.medium)
                        .font(.footnote)
                    Text(phone)
                        .font(.footnote)
                    Text(address)
                        .font(.footnote)
                    Text(postalcode)
                        .font(.footnote)
                }
            }
            Image(systemName: "checkmark")
        }
        .padding()
    }
}

struct LocationCard_Previews: PreviewProvider {
    static var previews: some View {
        LocationCard()

//            .frame(width: 357, height: 141)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
            .padding()
    }
}
