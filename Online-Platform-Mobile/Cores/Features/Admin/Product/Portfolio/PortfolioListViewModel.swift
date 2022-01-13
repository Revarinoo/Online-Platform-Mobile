//
//  PortfolioListViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 13/01/22.
//

import Foundation

class PortfolioListViewModel: ObservableObject {
    @Published var portfolios: [PortfoliosModel] = []
    private let service = PortfolioService()
    @Published var isUpdated = false
    
    func getPortfoliosByProductId(productId: Int) {
        service.getPortfoliosByProductId(productId: productId) { result in
            if let result = result {
                self.portfolios = result
            }
        }
    }
    
    
    func updatePortfoliosByProductId(productId: Int) {
        service.updatePortfoliosByProductId(productId: productId) { code in
            if code == 200 {
                self.isUpdated = true
            }
        }
    }
    
}
