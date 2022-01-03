//
//  SellerReviewViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 04/01/22.
//

import Foundation

class SellerReviewViewModel: ObservableObject {
    private let reviewService = ReviewService()
    @Published var review = OrderReviewModel()
    
    func getReviewByOrder(orderId: Int) {
        reviewService.getReviewByOrder(orderId: orderId) { [weak self] result in
            if let result = result {
                self?.review = result
            }
        }
    }
}
