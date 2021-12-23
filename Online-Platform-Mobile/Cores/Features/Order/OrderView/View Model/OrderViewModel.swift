//
//  OrderViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    static let shared = OrderViewModel()
    private var orderService = OrderService()
    @Published var order: CreateOrder = CreateOrder()
    @Published var isNavigate: Bool = false
    @Published var orderId: Int = 0
    @Published var pendingOrders: [MyOrderModel] = []
    @Published var upcomingOrders: [MyOrderModel] = []
    @Published var completedOrders: [MyOrderModel] = []
    
    func createOrder(carts: [ProductPackage], shipping: String) {
        var tempId: [Int] = []
        for data in carts {
            tempId.append(data.id!)
        }
        order.packages = tempId
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        orderService.createOrder(orderRequest: PostOrderRequest(price: calculateCart(carts: carts), location: order.location, schedule_date: order.schedule_date.serverFormattedDate(), schedule_time: dateFormatter.string(from: order.schedule_time), packages: order.packages, shipping_address: shipping)) { result in
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
    
    func getAllOrder() {
        orderService.getAllOrder { result in
            if let response = result {
                if response.code == 201 {
                    var temp: [MyOrderModel] = []
                    for data in response.data {
                        temp.append(MyOrderModel(order_id: data.order_id, photo: data.photo, name: data.name, order_date: data.order_date, order_category: data.order_category, status: data.status))
                    }
                    DispatchQueue.main.async {
                        self.pendingOrders = temp.filter { $0.status == "Pending" }
                        self.upcomingOrders = temp.filter { $0.status == "Upcoming" }
                        self.completedOrders = temp.filter { $0.status == "Completed" }
                    }
                }
            }
        }
    }
    
    func cancelOrder(orderId: Int) {
        orderService.updateOrderStatus(orderId: orderId, status: "Cancelled")
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(300)) { [weak self] in
            self?.getAllOrder()
        }
    }
}
