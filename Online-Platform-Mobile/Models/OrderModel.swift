//
//  OrderModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation

struct CreateOrder {
    var location: String = String()
    var schedule_date: Date = Date()
    var schedule_time: Date = Date()
    var packages: [Int] = []
}
