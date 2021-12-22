//
//  Rating.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 20/12/21.
//

import SwiftUI

struct Rating: View {
    
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.theme.primary
    var onColor = Color.theme.primary
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                getImage(for: number)
                    .resizable()
                    .frame(width: 52, height: 52)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
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

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: .constant(4))
    }
}
