//
//  File.swift
//  
//
//  Created by Timothy Dillman on 7/2/21.
//

import Foundation
/**
 Used to create a specific date given a calendar.  Useful for when a specific date needs to be created and create a specific format as an example.  Allows controlling how a date is created so that it can be compared to another date producing function or used to ensure a date formatter is working as expected.
 */
struct UTestDate {
    static func createDate(hour: Int, minute: Int, second: Int, year: Int, month: Int, day: Int, calendar: Calendar) -> Date {
        let refDate: Date = Date()
        var components = calendar.dateComponents([.hour, .minute, .second, .year, .month, .day], from: refDate)
        components.hour = hour
        components.minute = minute
        components.second = second
        components.day = day
        components.month = month
        components.year = year
        components.calendar = calendar
        return components.date!
    }
}
