//
//  OrderDetailSellerViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import Foundation

class OrderDetailSellerViewModel: ObservableObject {
    @Published var detailModel = OrderDetailSeller()
    private var orderDetailService = OrderDetailService()
    private var orderService = OrderService.shared
    @Published var showDeliveryAddress = false
    
    func getOrderDetail(orderId: Int) {
        orderDetailService.getSellerOrderDetail(orderId: orderId) { [weak self] response in
            if let response = response {
                self?.detailModel = response
                self?.showDeliveryAddress = response.shipping_address == "" ? false : true
            }
        }
    }
    
    func updateOrder(orderId: Int, status: String) {
        orderService.updateOrderStatus(orderId: orderId, status: status)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.getOrderDetail(orderId: orderId)
        }
    }
    
    func startChat(orderId: Int) {
        var id: Int = 0
        orderService.getUserByOrder(orderId: orderId) { userId in
            if let userId = userId {
                id = userId
            }
        }
        _ = ChatRoomViewModel().createChatRoom(target: id)
    }
}
