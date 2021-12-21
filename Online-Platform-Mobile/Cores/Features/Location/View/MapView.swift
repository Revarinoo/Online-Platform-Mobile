//
//  MapView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var locationList: LocationList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Map(coordinateRegion: getLocation(), interactionModes: .all, annotationItems: [locationList]) { location in
                MapMarker(coordinate: location.coordinate)
            }
            Button {
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Choose")
                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 6, leading: 25, bottom: 6, trailing: 25))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 60, alignment: .center)
                    .background(Color.theme.primary)
                    .cornerRadius(10)
            }

        }
    }
    
    private func getLocation() -> Binding<MKCoordinateRegion> {
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
}
