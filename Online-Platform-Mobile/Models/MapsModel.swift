//
//  MapsModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 08/01/22.
//

import Foundation

struct NearbyPlaceModel: Codable {
    let results: [NearbyResult]
}

struct NearbyResult: Codable {
    let name: String
    let photos: [NearbyPhotos]?
}

struct NearbyPhotos: Codable {
    let photo_reference: String
}
