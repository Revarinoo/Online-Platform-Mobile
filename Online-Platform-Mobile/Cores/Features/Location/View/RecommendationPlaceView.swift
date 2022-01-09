//
//  RecommendationPlaceView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import SwiftUI
import MapKit
import Introspect

struct RecommendationPlaceView: View {
    @StateObject private var locationVM = LocationViewModel()
    @State var showPhotos = false
    @State var uiTabarController: UITabBarController?
    
    var body: some View {
        VStack {
            Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(MapUserTrackingMode.none), annotationItems: locationVM.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    VStack {
                        VStack {
                            Text(landmark.name)
                                .foregroundColor(Color.black)
                                .font(.custom(ThemeFont.displayMedium, size: 12))
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(6)
                            .frame(maxHeight: 30)
                        }.fixedSize()
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 40, height: 40)
                    }
                    .onTapGesture {
                        locationVM.getNearbyPlacePhoto(coordinate: landmark.coordinate)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showPhotos.toggle()
                        }
                    }
                }
            }
            .onAppear {
                locationVM.mappingPhotoRecommendation()
            }
            .fullScreenCover(isPresented: $showPhotos, content: {
                PhotoPlacesDetailView(references: locationVM.references, show: $showPhotos)
            })
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Recommendation Place")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = locationVM.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
}

struct RecommendationPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationPlaceView()
    }
}
