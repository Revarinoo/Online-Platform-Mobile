//
//  PortfolioListView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/01/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Introspect

struct PortfolioListView: View {
    @StateObject private var portfolioVM = PortfolioListViewModel()
    var productId: Int
    var category: String
    @State var uiTabBarController: UITabBarController?
    var productVM: AdminProductViewModel
    var userId: Int
    @State private var showButton = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(portfolioVM.portfolios, id:\.id) { portfolio in
                    VStack {
                        WebImage(url: URL(string: portfolio.image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 94, height: 100)
                            .cornerRadius(7.7)
                        if portfolio.category_suggestion != "" {
                            HStack {
                                Image(systemName: portfolio.category_suggestion == category ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(portfolio.category_suggestion == category ? Color.theme.darkGreen : Color.red)
                                    .frame(width: 15, height: 14)
                                Text(portfolio.category_suggestion)
                                    .font(.custom(ThemeFont.displayRegular, size: 15))
                                .foregroundColor(portfolio.category_suggestion == category ? Color.theme.darkGreen : Color.red)
                                .onAppear {
                                    if portfolio.category_suggestion != category {
                                        self.showButton = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
            if showButton {
                button
            }
        }
        .navigationBarTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            portfolioVM.getPortfoliosByProductId(productId: self.productId)
        }
        .introspectTabBarController { UITabBarController in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }
        .onDisappear {
            uiTabBarController?.tabBar.isHidden = false
        }
    }
    
    var button: some View {
        VStack {
            Button {
                portfolioVM.updatePortfoliosByProductId(productId: productId)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Ignore Warning")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.white)
                    .background(Color.theme.primary)
                    .cornerRadius(15)
            }
            
            Button {
                productVM.removeProduct(productId: productId, userId: self.userId)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delete Product")
                    .font(.custom(ThemeFont.displaySemiBold, size: 18))
                    .frame(width: 358, height: 50)
                    .foregroundColor(Color.white)
                    .background(Color.theme.orange)
                    .cornerRadius(15)
            }

        }
    }
}

struct PortfolioListView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListView(productId: 1, category: "", productVM: AdminProductViewModel(), userId: 1)
    }
}
