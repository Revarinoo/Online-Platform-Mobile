//
//  ReviewViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/12/21.
//

import Foundation

class ReviewViewModel: ObservableObject {
    private var reviewService = ReviewService()
    @Published var isDone = false
    
    func addReview(orderId: Int, comment: String, rating: Int) {
        reviewService.addReview(orderId: orderId, comment: comment, rating: rating) { result in
        }
    }
    
}
