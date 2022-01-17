//
//  LocationService.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import Foundation
import Alamofire
import MapKit

class LocationService {
    
    func getNearbyPlace(coordinate: CLLocationCoordinate2D, completionHandler: @escaping(_ result: NearbyPlaceModel?)->Void) {
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=500&key=AIzaSyA5rh41FwuuWTWZV7ijA9sWn6W-Z8pX1wQ"
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if let response = response.data {
                    let data = try? JSONDecoder().decode(NearbyPlaceModel.self, from: response)
                    completionHandler(data)
                }
            }
    }
}
