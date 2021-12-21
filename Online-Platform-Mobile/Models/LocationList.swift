//
//  LocationList.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import Foundation
import MapKit

struct LocationList: Identifiable {
    let placemark: MKPlacemark
    let id = UUID()
    var name: String {
        return placemark.name ?? ""
    }
    var title: String {
        return placemark.title ?? ""
    }
    var coordinate: CLLocationCoordinate2D {
        return placemark.coordinate
    }
}
