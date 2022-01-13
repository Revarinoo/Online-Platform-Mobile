//
//  PromoViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/01/22.
//

import Foundation

class PromoViewModel: ObservableObject {
    @Published var promos: [PromoModel] = []
    
    func getAllPromo() {
        OrderService.shared.getAllPromo { result in
            if let result = result {
                self.promos = result
            }
        }
    }
}
