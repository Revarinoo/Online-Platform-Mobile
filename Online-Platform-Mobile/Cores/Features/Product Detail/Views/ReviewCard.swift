//
//  ReviewCard.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/11/21.
//

import SwiftUI

struct ReviewCard: View {
    var review: Review
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(review: Review(name: "Jonathan", comment: "Good"))
    }
}
