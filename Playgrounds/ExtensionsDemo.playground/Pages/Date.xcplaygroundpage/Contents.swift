//: Playground - noun: a place where people can play

//: [Previous](@previous)
//: [Next](@next)

import UIKit
import Mia



/***********************
    Inits & Formats
 ***********************/

let now = Date()

// Components
let n = now.components
Date(year: n.year!, month: n.month!, day: n.day!, hour: n.hour!, minute: n.minute!, second: n.second!)

// Custom format
let customFormat = DateFormatter.Presets.custom("dd MMM yyyy HH:mm:ss")
var string = now.format(to: customFormat)
Date(fromString: now.format(to: customFormat), format: customFormat)

// Standard
string = now.format(to: .standard)
Date(fromString: now.format(to: .standard), format: .standard)

// ISO8601 Date
string = now.format(to: .isoDate)
Date(fromString: string, format: .isoDate)

// ISO8601 Date & Time
string = now.format(to: .isoDateTime)
Date(fromString: string, format: .isoDateTime)

// ISO8601 Date & Time & Sec
string = now.format(to: .isoDateTimeSec)
Date(fromString: string, format: .isoDateTimeSec)

// ISO8601 Date & Time & MilliSec
string = now.format(to: .isoDateTimeMilliSec)
Date(fromString: string, format: .isoDateTimeMilliSec)

// DotNet
string = now.format(to: .dotNet)
Date(fromString: string, format: .dotNet)

// DotNetString
string = now.format(to: .dotNetString)
Date(fromString: string, format: .dotNetString)

// HTTP Header
string = now.format(to: .httpHeader)
Date(fromString: string, format: .httpHeader)

// RSS
string = now.format(to: .rss(alt: false))
Date(fromString: string, format: .rss(alt: false))

// AltRSS
string = now.format(to: .rss(alt: true))
Date(fromString: string, format: .rss(alt: true))

// - Readable
now.format(to: .date)                // Date
now.format(to: .time)                // Time
now.format(to: .dateTime)            // DateTime


// - Relative
now.formatRelative()

let thirtySecondsForward = now.adjust(.second, offset: 30)
thirtySecondsForward.formatRelative()

let thirtySecondsBack = now.adjust(.second, offset: -30)
thirtySecondsBack.formatRelative()

let lastHour = now.adjust(.hour, offset: -1)
lastHour.formatRelative()

let nextHour = now.adjust(.hour, offset: 1)
nextHour.formatRelative()

let twoHoursForward = now.adjust(.hour, offset: 2)
twoHoursForward.formatRelative()

let twoHoursBack = now.adjust(.hour, offset: -2)
twoHoursBack.formatRelative()

let twoDaysForward = now.adjust(.day, offset: 2)
twoDaysForward.formatRelative()

let twoDaysBack = now.adjust(.day, offset: -2)
twoDaysBack.formatRelative()

let nextWeek = now.adjust(.week, offset: 1)
nextWeek.formatRelative()

let lastWeek = now.adjust(.week, offset: -1)
lastWeek.formatRelative()

let twoWeeksForward = now.adjust(.week, offset: -2)
twoWeeksForward.formatRelative()

let twoWeeksBack = now.adjust(.week, offset: 2)
twoWeeksBack.formatRelative()

let nextMonth = now.adjust(.month, offset: 1)
nextMonth.formatRelative()

let lastMonth = now.adjust(.month, offset: -1)
lastMonth.formatRelative()

let twoMonthsForward = now.adjust(.month, offset: 2)
twoMonthsForward.formatRelative()

let twoMonthsBack = now.adjust(.month, offset: -2)
twoMonthsBack.formatRelative()

let nextYear = now.adjust(.year, offset: 1)
nextYear.formatRelative()

let lastYear = now.adjust(.year, offset: -1)
lastYear.formatRelative()

now.dateFor(.previous(.year))

let twoYearsForward = now.adjust(.year, offset: 2)
twoYearsForward.formatRelative()

let twoYearsBack = now.adjust(.year, offset: -2)
twoYearsBack.formatRelative()




let tomorrow = now.dateFor(.next(.day))
tomorrow.formatRelative()

let yesterday = now.dateFor(.previous(.day))
yesterday.formatRelative()


102.ordinal








//
//
///***********************
// Comparing Dates
// ***********************/
//
//// Is today
//tomorrow.compare(.isToday)
//now.compare(.isToday)
//
//// Is tomorrow
//now.compare(.isTomorrow)
//tomorrow.compare(.isTomorrow)
//
//// Is yesterday
//now.compare(.isYesterday)
//yesterday.compare(.isYesterday)
//
//// Is same day
//now.compare(.isSameDay(as: yesterday))
//now.compare(.isSameDay(as: now))
//
//// Is same week as date
//now.compare(.isSameWeek(as: yesterday))
//now.compare(.isSameWeek(as: now))
//
//// Is same month as date
//now.compare(.isSameMonth(as: nextMonth))
//now.compare(.isSameMonth(as: now))
//
//// Is this week
//nextWeek.compare(.isThisWeek)
//now.compare(.isThisWeek)
//
//// Is next week
//now.compare(.isNextWeek)
//nextWeek.compare(.isNextWeek)
//
//// Is last week
//now.compare(.isLastWeek)
//lastWeek.compare(.isLastWeek)
//
//// Is same year
//now.compare(.isSameYear(as: nextYear))
//now.compare(.isSameYear(as: tomorrow))
//
//// Is next year
//now.compare(.isNextYear)
//nextYear.compare(.isNextYear)
//
//// Is last year
//now.compare(.isLastYear)
//lastYear.compare(.isLastYear)
//
//// Earlier than
//tomorrow.compare(.isEarlier(than: now))
//lastWeek.compare(.isEarlier(than: now))
//
//// Later than
//yesterday.compare(.isLater(than: now))
//nextWeek.compare(.isLater(than: now))
//
//// Future
//now.compare(.isInTheFuture)
//nextWeek.compare(.isInTheFuture)
//
//// Past
//tomorrow.compare(.isInThePast)
//lastWeek.compare(.isInThePast)
//
//
///***********************
// Adjusting Dates
// ***********************/
//
//now.adjust(.second, offset: 110)
//now.adjust(.minute, offset: 60)
//now.adjust(.hour, offset: 2)
//now.adjust(.day, offset: 1)
//now.adjust(.weekday, offset: 2)
//now.adjust(.nthWeekday, offset: 1)
//now.adjust(.week, offset: 1)
//now.adjust(.month, offset: 1)
//now.adjust(.year, offset: 1)
//now.adjust(hour: 12, minute: 0, second: 0)
//
//
///***********************
// Create Dates For
// ***********************/
//
//now.dateFor(.startOfDay)
//now.dateFor(.endOfDay)
//now.dateFor(.startOfWeek)
//var calendar = Calendar(identifier: .gregorian)
//calendar.firstWeekday = 2
//now.dateFor(.startOfWeek, calendar: calendar)
//now.dateFor(.endOfWeek)
//now.dateFor(.startOfMonth)
//now.dateFor(.endOfMonth)
//now.dateFor(.tomorrow)
//now.dateFor(.yesterday)
//now.dateFor(.nearestMinute(minute:30))
//now.dateFor(.nearestHour(hour:2))
//
//
//
///***********************
// Time Since In...
// ***********************/
//
//now.since(thirtySecondsBack, in: .second)
//now.since(twoHoursBack, in: .minute)
//now.since(twoHoursBack, in: .hour)
//now.since(yesterday, in: .day)
//now.since(nextWeek, in: .week)
//now.since(twoWeeksBack, in: .nthWeekday)
//now.since(lastWeek, in: .week)
//now.since(lastMonth, in: .month)
//now.since(lastYear, in: .year)
//
//
///***********************
// Extracting Components
// ***********************/
//
//now.component(.second)
//now.component(.minute)
//now.component(.hour)
//now.component(.day)
//now.component(.weekday)
//now.component(.nthWeekday)
//now.component(.month)
//now.component(.year)
//
//now.numberOfDaysInMonth()
//now.firstDayOfWeek()
//now.lastDayOfWeek()
//
//
//
