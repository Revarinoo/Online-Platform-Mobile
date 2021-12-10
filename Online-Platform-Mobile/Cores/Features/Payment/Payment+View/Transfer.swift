//
//  Transfer.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 30/11/21.
//

import SwiftUI

struct Transfer: View {
    var body: some View {
        HStack (alignment: .top, spacing: 15){
            ZStack {
                Circle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(Color.theme.primary)
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 24, height: 18)
                    .foregroundColor(Color.theme.primarywhite)
            }
            .frame(width: 44, height: 44)
            
            VStack (alignment: .leading, spacing: 5){
                
                Text("PT. Jaya Makmur")
                Text("085 000 1111")
                    .fontWeight(.bold)
                    .frame(width: 265, height: 33, alignment: .leading)
                    .padding(.leading,20)
                    .background(Color.theme.lightgrey)
                    .cornerRadius(10)
                Spacer()
                Text("Amount to Pay")
                Text("Rp805.000")
                    .fontWeight(.bold)
                    .frame(width: 265, height: 33, alignment: .leading)
                    .padding(.leading,20)
                    .background(Color.theme.lightgrey)
                    .cornerRadius(10)
            }
            
        }
        
    }
}

struct Transfer_Previews: PreviewProvider {
    static var previews: some View {
        Transfer()
            .padding()
            .frame(width: 358, height: 167, alignment: .top)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
    }
}
