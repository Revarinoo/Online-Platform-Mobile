//
//  OrderDetailSellerViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import Foundation

class OrderDetailSellerViewModel: ObservableObject {
    private var orderDetailService = OrderDetailService()
    
    func getOrderDetail(orderId: Int) {
        orderDetailService.getSellerOrderDetail(orderId: orderId)
    }
}
