//
//  OvalTextFieldStyle.swift
//  Online-Platform-Mobile
//
//  Created by Kenneth J on 23/12/21.
//

import Foundation
import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .font(Font.custom(ThemeFont.displayMedium , size: 13))
            .padding(.bottom, 5)
            .padding(.top, -5)
    }
}

struct OvalTextFieldStyleForm: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(Color.theme.lightgrey)
            .cornerRadius(10)
            .font(Font.custom(ThemeFont.displayRegular, size: 14))
            .padding(.bottom, 5)
            .padding(.top, -5)
    }
}
