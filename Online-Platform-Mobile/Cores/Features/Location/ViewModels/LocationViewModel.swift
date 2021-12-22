//
//  LocationViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import Foundation
import MapKit

class LocationViewModel: ObservableObject {
    @Published var landmarks: [LocationList] = []
    
    func searchLocation(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print(error)
            }
            else if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    return LocationList(placemark: $0.placemark)
                }
            }
        }
    }
}
