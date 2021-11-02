//
//  HomeClient.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 15/10/21.
//

import SwiftUI

struct HomeClient: View {
    
    var homeClientVM = HomeClientViewModel()
    
    @StateObject var categoryListVM = CategoryListViewModel()
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.primary)]
    }
    
    var body: some View {
        NavigationView {
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
                        Text("View All")
                            .foregroundColor(.gray)
                    }
                    
                    ScrollView (.vertical, showsIndicators: false, content: {
                        VStack {
                            ForEach(0..<10) { index in
                                SellerCard()
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.2), radius: 2.5, x: 0, y: 1.5)
                            }
                        }
                    })
                }
                .padding()
                
            }.edgesIgnoringSafeArea(.bottom)
                .edgesIgnoringSafeArea(.trailing)
            .navigationBarTitle("Discover")
            .navigationBarItems(leading:
                                    Button(action: {
                homeClientVM.signOut()
            }) {
                Text("Log Out")
                    .foregroundColor(.red)
            }, trailing:
                                    Button(action: {
                print("Edit button pressed...")
            }) {
                Image(systemName: "message").imageScale(.large)
                    .foregroundColor(Color.theme.primary)
            })
        }
        
        
    }
}

struct HomeClient_Previews: PreviewProvider {
    static var previews: some View {
        HomeClient()
    }
}
