//
//  ProductDetailView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @StateObject var productDetailVM = ProductDetailViewModel()
    @State var productId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            ZStack {
                ImageSlider(images: productDetailVM.productDetailModel)
                VStack {
                    HStack {
                        Button(action:{
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundColor(Color.theme.primary)
                                .scaledToFit()
                                .frame(width: 8.36, height: 14.5)
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                        .background(Color.theme.primarywhite)
                        .cornerRadius(10)
                        Spacer()
                    }.padding(EdgeInsets(top: 44, leading: 16, bottom: 275, trailing: 0))
                    
                    VStack (alignment: .leading, spacing: 24) {
                        VStack (alignment: .leading) {
                            Text(productDetailVM.productDetailModel.category)
                                .font(.custom(ThemeFont.displayBold, size: 24))
                                .foregroundColor(Color.theme.primary)
                            Text(productDetailVM.productDetailModel.seller_type)
                                .font(.custom(ThemeFont.displayRegular, size: 13.5))
                                .foregroundColor(Color.theme.darkGrey)
                        }
                        .padding(EdgeInsets(top: 27, leading: 16, bottom: 0, trailing: 0))
                        HStack (spacing: 28) {
                            LocationRating(type: "Location", location: productDetailVM.productDetailModel.location)
                            LocationRating(type: "Rating", rating: productDetailVM.productDetailModel.rating, reviewCount: productDetailVM.productDetailModel.reviews.count)
                        }
                        .padding(.leading, 16)
                        
                        VStack {
                            Text("Reviews")
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    Spacer()
                }
            }
            .frame(width: 390, height: UIScreen.main.bounds.height)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: 390, minHeight: UIScreen.main.bounds.height + 15, maxHeight: .infinity)
        .onAppear {
            productDetailVM.getDetail(productId: productId)
            productDetailVM.refresh(productId: productId)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productId: 1)
    }
}
