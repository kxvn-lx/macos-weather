//
//  Extensions+.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import Foundation
import SwiftUI

extension Date {
    func isToday(dateString: String, format: String = "yyyy-MM-dd") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: dateString) else {
            return false
        }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        let todayComponents = calendar.dateComponents([.day, .month, .year], from: date)
        return dateComponents.year == todayComponents.year && dateComponents.month == todayComponents.month && dateComponents.day == todayComponents.day
    }
    
    func getReadable(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)

        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: date!)
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        // Scan hex value and convert to a UInt64
        scanner.scanHexInt64(&rgbValue)

        // Create a Color object from the UInt64 value
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000ff) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}


extension NSTableView {
  open override func viewDidMoveToWindow() {
    super.viewDidMoveToWindow()

    backgroundColor = NSColor.clear
    enclosingScrollView!.drawsBackground = false
  }
}
