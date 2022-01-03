//
//  SubmitComplainViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import Foundation

class SubmitComplainViewModel: ObservableObject {
    @Published var complainMessage = ""
    
    func submitComplain(orderId: Int) {
        OrderService().submitComplain(orderId: orderId, message: complainMessage)
    }
}
