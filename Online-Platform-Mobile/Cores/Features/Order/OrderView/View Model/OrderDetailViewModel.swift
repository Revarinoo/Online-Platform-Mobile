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
    @Published var isExpired = false
    
    func getOrderDetail(orderId: Int) {
        orderService.getClientOrder(orderId: orderId) { result in
            if let result = result {
                DispatchQueue.main.async { [weak self] in
                    self?.orderDetail = result
                    self?.isExpired = self!.checkExpired(date: result.order_date)
                }
            }
        }
    }
    
    private func checkExpired(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let newDate = dateFormatter.date(from: date)
        if Date() < newDate! {
            return false
        }
        return true
    }
    
    func rescheduleOrder(orderId: Int, date: Date) {
        orderService.rescheduleOrder(orderId: orderId, schedule_date: date.serverFormattedDate())
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) { [weak self] in
            self?.getOrderDetail(orderId: orderId)
        }
    }
}
