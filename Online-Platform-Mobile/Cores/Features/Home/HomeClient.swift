//
//  HomeClient.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import SwiftUI
import Introspect

struct HomeClient: View {
    
    @StateObject var homeClientVM = HomeClientViewModel()
    @State var uiTabarController: UITabBarController?
    @StateObject var categoryListVM = CategoryListViewModel()
    @State var isActive = false
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
    }
    
    var body: some View {
            ScrollView (.vertical, showsIndicators: false, content: {
                VStack (alignment: .leading) {
                    CouponCard()
                        .padding()
                    VStack (alignment: .leading) {
                        Text("Categories")
                            .foregroundColor(Color.theme.primary)
                            .font(.title3)
                            .fontWeight(.bold)
                        ScrollView (.horizontal, showsIndicators: false, content: {
                            HStack {
                                ForEach(categoryListVM.categories, id: \.self) { category in
                                    CategoryCard(name: category.name!, image: category.image!)
                                }
                            }
                        })
                    }
                    .padding(.leading)
                    
                    VStack {
                        HStack {
                            Text("Recommendation")
                                .foregroundColor(Color.theme.primary)
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        ScrollView (.vertical, showsIndicators: false, content: {
                            VStack {
                                ForEach(homeClientVM.recseller, id: \.self) { seller in
                                    NavigationLink(destination: ProductDetailView(productId: seller.product_id ?? 1)
                                                    .onAppear(perform: {
                                        uiTabarController?.tabBar.isHidden = true
                                    })
                                    ) {
                                        SellerCard(name: seller.name ?? "", category: seller.seller_type ?? [], image: seller.photo ?? "", rate: seller.rating)
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(0.2), radius: 2.5, x: 0, y: 1.5)
                                    }
                                }
                            }
                        })
                    }
                    .padding()
                    
                }.edgesIgnoringSafeArea(.bottom)
                    .edgesIgnoringSafeArea(.trailing)
                .navigationBarItems(trailing:
                                        NavigationLink(destination: ChatList(), isActive: $isActive) {
                    Button(action: {
                        isActive.toggle()
                    }) {
                    Image(systemName: "message").imageScale(.large)
                        .foregroundColor(Color.theme.primary)
                    }
                }
                )
            })
        
            .introspectTabBarController { (UITabBarController) in
                                    UITabBarController.tabBar.isHidden = false
                                    uiTabarController = UITabBarController
                                }
            .onAppear {
                uiTabarController?.tabBar.isHidden = false
            }
    }
}

struct HomeClient_Previews: PreviewProvider {
    static var previews: some View {
        HomeClient()
    }
}
