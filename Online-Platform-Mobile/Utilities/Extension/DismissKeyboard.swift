//
//  DismissKeyboard.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 14/11/21.
//

import Foundation

import SwiftUI

extension View {
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
