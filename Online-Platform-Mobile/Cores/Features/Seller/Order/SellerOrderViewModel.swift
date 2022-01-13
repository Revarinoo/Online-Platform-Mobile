//
//  SellerOrderViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 23/12/21.
//

import Foundation

class SellerOrderViewModel: ObservableObject {
    @Published var pendingOrders: [MyOrderModel] = []
    @Published var upcomingOrders: [MyOrderModel] = []
    @Published var completedOrders: [MyOrderModel] = []
    private let orderService = OrderService.shared
    
    func getAllOrderSeller() {
        orderService.getAllOrderSeller { result in
            if let response = result {
                if response.code == 200 {
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
}
