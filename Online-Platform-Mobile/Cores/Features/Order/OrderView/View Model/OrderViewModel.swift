//
//  OrderViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    private var orderService = OrderService()
    @Published var order: CreateOrder = CreateOrder()
    @Published var isNavigate: Bool = false
    @Published var orderId: Int = 0
    
    func createOrder(carts: [ProductPackage]) {
        var tempId: [Int] = []
        for data in carts {
            tempId.append(data.id!)
        }
        order.packages = tempId
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        orderService.createOrder(orderRequest: PostOrderRequest(price: calculateCart(carts: carts), location: order.location, schedule_date: order.schedule_date.serverFormattedDate(), schedule_time: dateFormatter.string(from: order.schedule_time), packages: order.packages)) { result in
            if let result = result {
                if result.code == 201 {
                    DispatchQueue.main.async {
                        self.isNavigate = true
                        self.orderId = result.order_id
                    }
                }
            }
        }
    }
    
    private func calculateCart(carts: [ProductPackage]) -> Double {
        var total: Double = 0
        for cart in carts {
            total += cart.price!
        }
        return total
    }
}
