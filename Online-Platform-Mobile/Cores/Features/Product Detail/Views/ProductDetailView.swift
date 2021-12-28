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
    @State var cart: [ProductPackage] = []
    @State var locationFlag = false
    @StateObject var chatVM = ChatRoomViewModel()
    @State var isCreated = false
    @State var isNavigate = false
    
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                ZStack {
                    ImageSlider(images: productDetailVM.productDetailModel)
                    VStack {
                        backButton
                       
                        //MARK: Content
                        VStack (alignment: .leading, spacing: 24) {
                            VStack (alignment: .leading) {
                                Text(productDetailVM.productDetailModel.category)
                                    .font(.custom(ThemeFont.displayBold, size: 24))
                                    .foregroundColor(Color.theme.primary)
                                Text(productDetailVM.productDetailModel.seller_type)
                                    .font(.custom(ThemeFont.displayRegular, size: 13.5))
                                    .foregroundColor(Color.theme.darkGrey)
                            }
                            .padding(EdgeInsets(top: 27, leading: 0, bottom: 0, trailing: 16))
                            HStack (spacing: 17) {
                                LocationRating(type: "Location", location: productDetailVM.productDetailModel.location)
                                LocationRating(type: "Rating", rating: productDetailVM.productDetailModel.rating, reviewCount: productDetailVM.productDetailModel.reviews.count)
                            }
                            .padding(.bottom, 10)
                            
                            VStack (alignment: .leading, spacing: 9) {
                                Text("Reviews")
                                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                if productDetailVM.productDetailModel.reviews.count == 0 {
                                    Text("N/A")
                                        .font(.custom(ThemeFont.displaySemiBold, size: 14))
                                        .foregroundColor(Color.theme.primary)
                                }
                                else {
                                    ScrollView (.horizontal, showsIndicators: false) {
                                        HStack (spacing: 15) {
                                            ForEach(productDetailVM.productDetailModel.reviews) { review in
                                                ReviewsCard(review: review)
                                                    .frame(height: 120)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                        .padding([.leading, .trailing], 8)
                                    }
                                }
                            }
            
                            descriptionView
                            sellerView
                            packageList
                            

                        }
                        .padding(.leading,16)
                        .padding(.trailing,16)
                        .frame(width: UIScreen.main.bounds.width, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            
            //MARK: Floating View
            VStack {
                Spacer()
                HStack {
                    Image("cartIcon")
                        .resizable()
                        .foregroundColor(Color.theme.primary)
                        .frame(width: 41, height: 36)
                    
                    Text("Rp \(productDetailVM.calculateCart(carts: cart))")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .foregroundColor(Color.theme.primary)
                        .padding(.leading, 9)
                        .frame(width: 181, alignment: .leading)
                    
                    NavigationLink(destination: OrderView(cart: cart, locationFlag: locationFlag)) {
                        Text("Checkout")
                            .font(.custom(ThemeFont.displaySemiBold, size: 15))
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 6, leading: 25, bottom: 6, trailing: 25))
                            .frame(width: 115, height: 33)
                            .background(Color.theme.primary)
                            .cornerRadius(10)
                    }
                    .opacity(cart.isEmpty ? 0.5 : 1)
                    .disabled(cart.isEmpty ? true : false)

                }
                .frame(width: UIScreen.main.bounds.width, height: 93)
                .background(Color.init(hex: "F7F7F7"))
                .padding(.bottom, 14)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: 390, minHeight: 860, maxHeight: .infinity, alignment: .top)
        .padding(.top, 50)
        
        .onAppear {
            productDetailVM.getDetail(productId: productId)
            productDetailVM.refresh(productId: productId)
        }
    }
    
    var backButton: some View {
        HStack {
            Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                VStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundColor(Color.theme.primary)
                        .scaledToFit()
                        .frame(width: 8.36, height: 14.5)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .background(Color.theme.primarywhite)
                .cornerRadius(10)
            }
            Spacer()
        }.padding(EdgeInsets(top: 44, leading: 16, bottom: 304, trailing: 0))
    }
    
    var sellerView: some View {
        VStack (alignment: .leading, spacing: 9) {
            Text("Photographer")
                .font(.custom(ThemeFont.displaySemiBold, size: 15))
            HStack {
                WebImage(url: URL(string: productDetailVM.productDetailModel.user.photo ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 49, height: 49)
                    .cornerRadius(10)
                
                Text(productDetailVM.productDetailModel.user.name ?? "")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                Spacer()
                NavigationLink(destination: ChatList(), isActive: $isNavigate) {
                    Button(action: {
                        isCreated = chatVM.createChatRoom(target: productDetailVM.productDetailModel.user.id ?? 0)
                        isNavigate = true
                    }) {
                        Text("Chat")
                            .font(.custom(ThemeFont.displaySemiBold, size: 15))
                            .foregroundColor(Color.theme.primary)
                    }
                    .frame(width: 94, height: 33)
                    .background(Color.theme.primarywhite)
                    .cornerRadius(10)
                }
                
            }
        }
    }
    
    var descriptionView: some View {
        VStack (alignment: .leading, spacing: 9) {
            Text("Description")
                .font(.custom(ThemeFont.displaySemiBold, size: 15))
            Text(productDetailVM.productDetailModel.description)
                .font(Font.custom(ThemeFont.displayRegular, size: 14))
                .foregroundColor(Color.init(hex: "979797"))
                .frame(minHeight: 100)
        }
    }
    
    var packageList: some View {
        VStack (alignment: .leading) {
            Text("Package List")
                .font(.custom(ThemeFont.displaySemiBold, size: 15))
            VStack (spacing: 15) {
                ForEach(productDetailVM.productDetailModel.packages, id: \.self) { package in
                    NavigationLink (destination: PackageDetail(package: package)) {
                        PackageCard(package: package, carts: $cart, locationFlag: $locationFlag)
                            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                    }
                }
            }
        }
        .padding(.bottom, 115)
    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productId: 1)
    }
}
