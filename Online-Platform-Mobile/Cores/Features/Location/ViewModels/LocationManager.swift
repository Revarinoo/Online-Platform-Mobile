//
//  LocationManager.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // still update location when user move
    }
    
    func startUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate, MKMapViewDelegate {
    
    // called when the user location updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.location = location
        }
    }
}
