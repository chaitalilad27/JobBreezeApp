//
//  DateFormatter.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 13/07/23.
//

import Foundation

// MARK: DateFormatter Extension
extension DateFormatter {

    // Static date formatter instance used for formatting dates
    static let defaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()

    /// Returns a formatted string representation of the provided date based on the elapsed time.
    ///
    /// - Parameters:
    ///   - date: The date to be formatted.
    /// - Returns: A string representation of the date based on the elapsed time.
    static func getDateString(for date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()

        // Check if the date is today
        if calendar.isDateInToday(date) {
            let components = calendar.dateComponents([.hour, .minute, .second], from: date, to: now)

            // Display relative time strings for hours, minutes, and seconds
            if let hour = components.hour, hour > 0 {
                return "\(hour)h ago"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute)m ago"
            } else if let second = components.second, second > 0 {
                return "\(second)s ago"
            } else {
                return "Just now"
            }
        }
        // Check if the date is yesterday
        else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        // Check if the date is more than one month ago
        else if let monthDiff = calendar.dateComponents([.month], from: date, to: now).month, monthDiff <= -1 {
            let formattedDate = defaultFormatter.string(from: date)
            return formattedDate
        }
        // Use the default format for dates within the current year
        else {
            let formattedDate = DateFormatter.defaultFormatter.string(from: date)
            return formattedDate
        }
    }
}
