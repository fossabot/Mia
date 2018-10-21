//
//  Date+Helpers.swift
//  test
//
//  Created by Michael Hedaitulla on 2/4/18.
//  Copyright © 2018 Western Beef. All rights reserved.
//

import Foundation


public class Constants {
    public static let SecondsInYear: TimeInterval = 31536000
    public static let SecondsInLeapYear: TimeInterval = 31622400
    public static let SecondsInMonth28: TimeInterval = 2419200
    public static let SecondsInMonth29: TimeInterval = 2505600
    public static let SecondsInMonth30: TimeInterval = 2592000
    public static let SecondsInMonth31: TimeInterval = 2678400
    public static let SecondsInWeek: TimeInterval = 604800
    public static let SecondsInDay: TimeInterval = 86400
    public static let SecondsInHour: TimeInterval = 3600
    public static let SecondsInMinute: TimeInterval = 60
    public static let MillisecondsInDay: TimeInterval = 86400000
    
    public static let AllCalendarUnitFlags: Set<Calendar.Component> = [ .year, .quarter, .month, .weekOfYear, .weekOfMonth, .day, .hour, .minute, .second, .era, .weekday, .weekdayOrdinal, .weekOfYear ]
}
