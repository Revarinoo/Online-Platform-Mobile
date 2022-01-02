//
//  SubmitResultViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/01/22.
//

import Foundation
import SwiftUI

class SubmitResultViewModel: ObservableObject {
    private let service = OrderResultService()
    @Published var successfullySubmitted = false
    
    func submitOrderResult(orderId: Int, result: String, images: [UIImage]) {
        service.submitOrderResult(orderId: orderId, result: result, images: images) { code in
            if code == 200 {
                self.successfullySubmitted = true
            }
        }
    }
}
