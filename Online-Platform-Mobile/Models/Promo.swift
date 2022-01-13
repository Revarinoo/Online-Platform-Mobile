//
//  Promo.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 12/01/22.
//

import Foundation

struct Promo: Codable {
    let promo_id: Int
    let code: String
    let percent_discount: Double
    let minumum_order: Double
    let maximum_discount: Double
}
