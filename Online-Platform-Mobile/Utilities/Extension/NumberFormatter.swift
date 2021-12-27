//
//  NumberFormatter.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 27/11/21.
//

import Foundation

extension Int {
    func setPriceFormat() -> String {
        if self == 0 {
            return "N/A"
        } else if self > 999999{
            return "\(String(format: "%g", Double(self)/1000000)) Million"
        } else if self > 999 {
            return "\(self/1000) K"
        } else {
            return "\(self)"
        }
    }
    
    func rupiahFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        return formatter.string(from: NSNumber(value: self))!
    }
}
