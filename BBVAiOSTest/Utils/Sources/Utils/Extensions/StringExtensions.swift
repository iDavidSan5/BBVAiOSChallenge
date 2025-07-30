//
//  StringExtensions.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//
import Foundation

public extension String {
    func toFormattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "es_ES")
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "es_ES")
        outputFormatter.dateFormat = "dd MMM yyyy"

        guard let date = inputFormatter.date(from: self) else { return "" }
        return outputFormatter.string(from: date)
    }
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
