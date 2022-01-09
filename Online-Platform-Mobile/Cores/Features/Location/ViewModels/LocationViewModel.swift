//
//  LocationViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import Foundation
import MapKit
import Combine

class LocationViewModel: ObservableObject {
    @Published var landmarks: [LocationList] = []
    @Published var currentLocation: CLLocationCoordinate2D?
    private let locationManager: LocationManager
    var cancellable: AnyCancellable?
    private let locationService = LocationService()
    @Published var references: [String] = []
    
    init() {
        self.locationManager = LocationManager()
        cancellable = locationManager.$location.sink { location in
            if let location = location {
                DispatchQueue.main.async {
                    self.currentLocation = location.coordinate
                    self.locationManager.stopUpdates()
                }
            }
        }
    }
    
    func mappingPhotoRecommendation() {
        self.customPlaces(query: "Rekreasi")
        self.customPlaces(query: "Wisata")
        self.customPlaces(query: "Waterpark")
    }
    
    func customPlaces(query: String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print(error)
            }
            else if let response = response {
                let mapItems = response.mapItems
                self.landmarks.append(contentsOf: mapItems.map {
                    return LocationList(placemark: $0.placemark)
                })
            }
        }
    }
    
    
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
    
    func getNearbyPlacePhoto(coordinate: CLLocationCoordinate2D) {
        self.references.removeAll()
        locationService.getNearbyPlace(coordinate: coordinate) { result in
            if let result = result {
                for data in result.results {
                    let photo = data.photos?.first?.photo_reference ?? "nil"
                    if photo != "nil" {
                        self.references.append(photo)
                    }
                }
            }
        }
    }
}
