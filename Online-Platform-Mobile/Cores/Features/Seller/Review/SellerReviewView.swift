//
//  SellerReviewView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 04/01/22.
//

import SwiftUI
import SDWebImageSwiftUI
import TextView

struct SellerReviewView: View {
    @StateObject private var reviewVM = SellerReviewViewModel()
    var orderId: Int
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 31) {
            HStack (spacing: 24) {
                WebImage(url: URL(string: reviewVM.review.user_photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 75)
                    .cornerRadius(6.46)
                VStack (alignment: .leading, spacing: 9) {
                    Text(reviewVM.review.user_name)
                        .font(.custom(ThemeFont.displayMedium, size: 20))
                    if reviewVM.review.rating != Int() {
                        HStack {
                            ForEach(0..<5, id: \.self) { index in
                                Image(index < reviewVM.review.rating ? "sellerStar" : "emptyStar")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 31, height: 29)
                            }
                        }
                    }
                    else {
                        Text("No Review yet")
                            .font(.custom(ThemeFont.displayMedium, size: 20))
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Comment")
                    .font(.custom(ThemeFont.displaySemiBold, size: 16))
                TextArea(text: .constant(reviewVM.review.comment), placeholder: "", isEditing: $isEditing)
            }
            Spacer()
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
        .padding(EdgeInsets(top: 23, leading: 16, bottom: 0, trailing: 16))
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            reviewVM.getReviewByOrder(orderId: orderId)
        }
    }
}

struct SellerReviewView_Previews: PreviewProvider {
    static var previews: some View {
        SellerReviewView(orderId: 3)
    }
}
