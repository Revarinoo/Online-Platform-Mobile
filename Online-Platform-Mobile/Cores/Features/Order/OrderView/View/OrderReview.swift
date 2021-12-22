//
//  OrderReview.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/12/21.
//

import SwiftUI

struct OrderReview: View {
    
    @State var comment: String =  "Thank you! Satisfied with the work and worth the price. Would love to reccomend you to my other friends!"
    
    @State var rating: Int = 3
    
    var maximumRating = 5
    
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.orange
    var onColor = Color.orange
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("welcomepage")
                    .resizable()
                    .frame(width: 70, height: 75)
                VStack(alignment: .leading, spacing: 5){
                    Text("Kenny Wijaya")
                        .font(.title2)
                    HStack {
                        ForEach(1..<maximumRating + 1, id: \.self) { number in
                            getImage(for: number)
                                .resizable()
                                .frame(width: 31, height: 31)
                                .foregroundColor(number > rating ? offColor : onColor)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Comment")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(comment)
                    .padding()
                    .frame(width: 358, height: 167, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            .padding()
            Spacer()
        }
        
    }
    
    func getImage(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }

}

struct OrderReview_Previews: PreviewProvider {
    static var previews: some View {
        OrderReview()
    }
}
