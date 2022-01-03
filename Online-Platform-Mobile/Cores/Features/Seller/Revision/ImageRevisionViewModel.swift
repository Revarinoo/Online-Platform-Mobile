//
//  ImageRevisionViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import Foundation

class ImageRevisionViewModel: ObservableObject {
    private let service = OrderResultService()
    @Published var revisions: [RevisionListModel] = []
    
    func getRevision(orderId: Int) {
        service.getOrderRevision(orderId: orderId) { [weak self] result in
            if let response = result {
                self?.revisions = response
            }
        }
    }
}
