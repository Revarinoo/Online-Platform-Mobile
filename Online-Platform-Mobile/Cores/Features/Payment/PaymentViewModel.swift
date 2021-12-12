//
//  PaymentViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 11/12/21.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class PaymentViewModel: ObservableObject {
    @Published var receiptImage: Image? = Image("")
    @Published var isShowingPhotoPicker = false
    @Published var isUploaded = true

//    func uploadReceipt(image: UIImage){
//        PhotoPicker(testImage: self.image)
//    }
}
