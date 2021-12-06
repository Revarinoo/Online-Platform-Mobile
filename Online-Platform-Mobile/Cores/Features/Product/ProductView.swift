//
//  ProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 06/11/21.
//

import SwiftUI
import Introspect

struct ProductView: View {
    
    @StateObject var categoryListVM = CategoryListViewModel()
    @StateObject var productListVM = ProductViewModel()
    @State var uiTabarController: UITabBarController?
    
    var body: some View {
            VStack {
                ScrollView (.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(categoryListVM.categories, id: \.self) { category in
                            CategoryIcon(image: category.icon ?? "", name: category.name ?? "")
                                .frame(minWidth: 63, maxHeight: 86)
                                .background(Color.theme.secondary)
                                .cornerRadius(10)
                                .onTapGesture {
                                    productListVM.selectedCategory = category.category_id ?? 1
                                    //productListVM.selectedCategory = category.id ?? 2
                                    productListVM.fetchSeller(catId: productListVM.selectedCategory)
                                    print(productListVM.selectedCategory)
                                }
                                .padding(.bottom, 21)
                        }
                    }
                    .padding(.leading)
                })
                ScrollView (.vertical, showsIndicators: false, content: {
                    VStack {
                        ForEach(productListVM.seller, id: \.self) { seller in
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
                    .padding(.horizontal)
                })
            }
            .introspectTabBarController { (UITabBarController) in
                                    UITabBarController.tabBar.isHidden = false
                                    uiTabarController = UITabBarController
                                }
            .onAppear {
                uiTabarController?.tabBar.isHidden = false
            }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
