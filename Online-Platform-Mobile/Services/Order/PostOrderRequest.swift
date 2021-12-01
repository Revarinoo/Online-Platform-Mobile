//
//  PostOrderRequest.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation

struct PostOrderRequest: Encodable {
    let price: Double
    let location: String
    let schedule_date: String
    let schedule_time: String
    let packages: [Int]
}

