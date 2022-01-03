//
//  OrderResultViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 30/12/21.
//  Edited by Reva on 02/01/2022

import Foundation

class OrderResultViewModel: ObservableObject {
    
    @Published var selectedPhoto: [OrderRevision] = []
    @Published var preview: Bool = false
    @Published var imagepreview = ""
    private let resultService = OrderResultService()
    @Published var results: [OrderRevision] = []
    @Published var revisionAvailable = false
    @Published var revisionSubmitted = false
    
    func removeSelected(selected: OrderRevision) {
        selectedPhoto.removeAll(where: {$0.id == selected.id})
    }
    
    func getOrderResult(orderId: Int) {
        resultService.getOrderResult(orderId: orderId) { [weak self] result, revisionAvailable in
            var tempResults: [OrderRevision] = []
            let availableResult = result.filter { $0.status == "Not Selected" }
            for data in availableResult {
                tempResults.append(OrderRevision(id: data.id, file_path: data.file_path, selected: false))
            }
            DispatchQueue.main.async {
                self?.results = tempResults
                self?.revisionAvailable = revisionAvailable
            }
        }
    }
    
    func requestRevision(orderId: Int) {
        var reports: [Int] = []
        for photo in selectedPhoto {
            reports.append(photo.id)
        }
        resultService.requestRevision(orderId: orderId, reports: reports) { code in
            if code == 200 {
                self.revisionSubmitted = true
            }
        }
    }
    
    func completeOrder(orderId: Int) {
        OrderService().updateOrderStatus(orderId: orderId, status: "Completed")
    }
    
}
