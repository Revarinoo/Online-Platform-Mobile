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
    private var orderService = OrderService.shared
    @Published var order: CreateOrder = CreateOrder()
    @Published var isNavigate: Bool = false
    @Published var orderId: Int = 0
    @Published var pendingOrders: [MyOrderModel] = []
    @Published var upcomingOrders: [MyOrderModel] = []
    @Published var completedOrders: [MyOrderModel] = []
    @Published var randValue: Int = 0
    
    func createOrder(carts: [ProductPackage], shipping: String, promoId: Int, disc: Int) {
        var tempId: [Int] = []
        for data in carts {
            tempId.append(data.id!)
        }
        order.packages = tempId
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        orderService.createOrder(orderRequest: PostOrderRequest(price: calculateCart(carts: carts, promoId: promoId, disc: disc), location: order.location, schedule_date: order.schedule_date.serverFormattedDate(), schedule_time: dateFormatter.string(from: order.schedule_time), packages: order.packages, shipping_address: shipping, promo_id: promoId == 0 ? nil : promoId)) { result in
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
    
    private func random() -> Double {
        var number = String()
        for _ in 1...3 {
           number += "\(Int.random(in: 5...9))"
        }
        self.randValue = Int(number)!
        return Double(number)!
    }
    
    private func calculateCart(carts: [ProductPackage], promoId: Int, disc: Int) -> Double {
        var total: Double = 0
        for cart in carts {
            total += cart.price!
        }
        if promoId != 0 {
            let discount = (Int(total) * disc)/100
            total -= Double(discount)
        }
        return total + random()
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
                        self.upcomingOrders = temp.filter { $0.status == "Upcoming" || $0.status == "Need Revision" || $0.status == "Not Submitted" || $0.status == "Waiting" }
                        self.completedOrders = temp.filter { $0.status == "Completed" }
                    }
                }
            }
        }
    }
    
    func cancelOrder(orderId: Int) {
        orderService.updateOrderStatus(orderId: orderId, status: "Cancelled")
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) { [weak self] in
            self?.getAllOrder()
        }
        TabBarViewModel.shared.resetNavigationID = UUID()
    }
}
