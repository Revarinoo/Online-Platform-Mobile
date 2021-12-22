//
//  GiveOrderReviewView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/12/21.
//

import SwiftUI

struct GiveOrderReviewView: View {
    
    @State var rate: Int = 3
    @State var reviewtext: String = ""
    
    var screenwidth =  UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            VStack {
                Text("How was your experience?")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image("welcomepage")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
            }
            VStack {
                Rating(rating: $rate)
                Text("Give 1 star for bad service, 5 for great")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Write a comment")
                    .font(.title3)
                    .fontWeight(.semibold)
                TextField("Share your experience here...", text: $reviewtext)
                    .padding()
                    .frame(width: 358, height: 167, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            .padding(.top, 30)
            .padding()
            PrimaryButton(content: "Submit", maxWidth: screenwidth, action: {}, btnColor: Color.theme.secondary, textColor: Color.theme.primary)
                .padding()
        }
        
    }
    
    
}

struct GiveOrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        GiveOrderReviewView()
    }
}
