//
//  TransactionViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 31/12/21.
//

import Foundation

class TransactionViewModel: ObservableObject {
    private let paymentService = PaymentService()
    private let orderService = OrderService.shared
    @Published var transactions: [TransactionListModel] = []
    
    func getTransactions() {
        paymentService.getTransactions { result in
            if let result = result {
                self.transactions = result
            }
        }
    }
    
    func updateOrderStatus(orderId: Int, status: String) {
        orderService.updatePaymentStatus(orderId: orderId, status: status)
        self.getTransactions()
    }
}
