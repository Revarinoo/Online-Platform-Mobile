//
//  PromoModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/01/22.
//

import Foundation

struct PromoModel: Codable, Identifiable {
    let id: Int
    let code: String
    let percent_discount: Int
    let minimum_order: Double
    let maximum_discount: Double
}
