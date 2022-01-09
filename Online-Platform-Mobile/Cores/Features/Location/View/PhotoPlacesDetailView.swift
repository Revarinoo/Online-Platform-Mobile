//
//  PhotoPlacesDetail.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoPlacesDetailView: View {
    var photoReference: [String]
    @Binding var showPage: Bool
    
    init(references: [String], show: Binding<Bool>) {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.theme.primary)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        self.photoReference = references
        _showPage = show
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            TabView {
                ForEach(1..<4) { index in
                    WebImage(url: URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(photoReference[index])&key=AIzaSyA5rh41FwuuWTWZV7ijA9sWn6W-Z8pX1wQ"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 60)
                }
            }
            
            .background(Color.white)
            .padding(20)
            
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                HStack {
                    Button {
                        showPage = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .foregroundColor(Color.theme.primary)
                            .scaledToFill()
                            .frame(width: 35, height: 30)
                            .padding([.leading, .top], 10)
                    }

                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct PhotoPlacesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPlacesDetailView(references: ["","",""], show: .constant(true))
    }
}
