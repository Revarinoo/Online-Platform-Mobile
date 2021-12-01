//
//  DateExtension.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/12/21.
//

import Foundation

extension Date {
    func serverFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
}
