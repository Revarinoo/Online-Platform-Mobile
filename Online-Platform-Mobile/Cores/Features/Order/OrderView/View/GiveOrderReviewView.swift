//
//  GiveOrderReviewView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 19/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Introspect
import TextView

struct GiveOrderReviewView: View {
    
    @State var rate: Int = 0
    @State var reviewtext: String = ""
    var orderId: Int
    var sellerImage: String
    @StateObject private var reviewVM = ReviewViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var uiTabBarController: UITabBarController?
    
    var screenwidth =  UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    Text("How was your experience?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    WebImage(url: URL(string: sellerImage))
                        .resizable()
                        .scaledToFill()
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
                    TextArea(text: $reviewtext, placeholder: "Share your experience here...", isEditing: .constant(true))
                }
                .padding(.top, 30)
                .padding()
                .padding(.bottom, 45)
                
                Button {
                    reviewVM.addReview(orderId: orderId, comment: reviewtext, rating: rate)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Submit")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: 358, height: 50)
                        .foregroundColor(Color.theme.primary)
                        .background(Color.theme.secondary)
                        .cornerRadius(15)
                }
                
            }
            .introspectTabBarController { UITabBarController in
                UITabBarController.tabBar.isHidden = true
                uiTabBarController = UITabBarController
            }
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
    
    
}

struct GiveOrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        GiveOrderReviewView(orderId: 3, sellerImage: "")
    }
}
