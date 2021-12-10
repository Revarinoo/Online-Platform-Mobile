//
//  OrderCard.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 04/12/21.
//

import SwiftUI

struct OrderCard: View {
    
    @State var orderdate = "21 November 2021"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 57, height: 57)
                    .scaledToFill()
                VStack (alignment: .leading, spacing: 5){
                    Text("Muhammad Ardie")
                    Label(orderdate, systemImage: "calendar")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                }
            }
            .padding()
            
            HStack {
                Spacer()
                Button(action: {}, label: {
                    Text("Cancel")
                        .foregroundColor(Color.red)
                        .frame(width: 113, height: 38)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.red, lineWidth: 1)
                        )
                })
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
        
    }
}

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        OrderCard()
            .frame(width: 357, height: 141)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
    }
}
