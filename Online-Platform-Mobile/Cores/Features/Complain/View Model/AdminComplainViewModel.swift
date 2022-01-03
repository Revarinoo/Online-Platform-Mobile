//
//  AdminComplainViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import Foundation

class AdminComplainViewModel: ObservableObject {
    private let service = OrderService()
    @Published var complains: [ComplainModel] = []
    @Published var navigate = false
    
    func getComplains() {
        service.getComplains { [weak self] result in
            if let result = result {
                self?.complains = result
            }
        }
    }
    
    func updateComplain(orderId: Int, status: String) {
        service.updateComplain(orderId: orderId, status: status) { [weak self] code in
            self?.navigate = true
            self?.getComplains()
        }
    }
}
