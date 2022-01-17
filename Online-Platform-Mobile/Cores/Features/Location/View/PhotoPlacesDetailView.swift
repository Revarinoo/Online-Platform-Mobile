//
//  PhotoPlacesDetail.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

enum CallAPI : Error {
    case unknown
    case noData
}

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
                    if photoReference.count < index {
                        WebImage(url: URL(string: getImage(reference: "")))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                    }else {
                        WebImage(url: URL(string: getImage(reference: photoReference[index])))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                    }
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
    
    private func getImage(reference: String) -> String {
        let img = try? callAPI(reference: reference)
        return img ?? "https://ik.imagekit.io/tvlk/loc-asset/gNr3hLh55ZCkPJisyxFK-v9MmzxPu57ZRVI+10VZ2S4b1PNW4T++cbA6yK4gzhAhs9o2HLZ9vs7gy3rpcIU+oKi5EygzQLRjTUv7fRblEVA=/images/1506074719291-1200x600-FIT_AND_TRIM-1cf0cfb159cf259f67fb7f97b894442a.jpeg?_src=imagekit&tr=c-at_max,h-400,q-40,w-1280"
    }
    
    private func callAPI(reference: String) throws -> String {
        if reference == "" {
            throw CallAPI.noData
        }
        else {
            return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(reference)&key=AIzaSyA5rh41FwuuWTWZV7ijA9sWn6W-Z8pX1wQ"
        }
    }
}

struct PhotoPlacesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPlacesDetailView(references: ["","",""], show: .constant(true))
    }
}
