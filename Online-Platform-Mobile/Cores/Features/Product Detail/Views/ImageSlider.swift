//
//  ImageSlider.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 14/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageSlider: View {
    
    var images: ProductDetailModel
    
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(images.portfolio, id: \.self) { image in
                    WebImage(url: URL(string: image))
                        .resizable()
                        .scaledToFill()
                        .tag(image)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(width: proxy.size.width, height: proxy.size.height / 2.3, alignment: .top)
            .edgesIgnoringSafeArea(.top)
        }
    }
}


