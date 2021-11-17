//
//  Categories.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 30/10/21.
//

import Foundation

struct Category: Codable {
    let category_id: Int?
    let name: String?
    let image: String?
    let icon: String?
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(category_id)
    }
}
