//
//  OrderDetailViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 21/12/21.
//

import Foundation

class OrderDetailViewModel: ObservableObject {
    @Published var orderDetail: ClientOrderDetail = ClientOrderDetail()
    private var orderService = OrderService()
    
    func getOrderDetail(orderId: Int) {
        orderService.getClientOrder(orderId: orderId) { result in
            if let result = result {
                DispatchQueue.main.async { [weak self] in
                    self?.orderDetail = result
                }
            }
        }
    }
}
