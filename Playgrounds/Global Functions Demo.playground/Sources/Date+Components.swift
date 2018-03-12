
//
//  Date+Components.swift
//  Mia
//
//  Created by Michael Hedaitulla on 2/4/18.
//

import Foundation

/**
 *  Extends the Date class by adding convenient accessors of calendar
 *  components. Meta information about the date is also accessible via
 *  several computed Bools.
 */
public extension Date {
    
    /**
     *  Convenient accessor of the date's `Calendar` components.
     *
     *  - parameter component: The calendar component to access from the date
     *
     *  - returns: The value of the component
     *
     */
    public func component(_ component: Calendar.Component) -> Int {
        
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    /**
     *  Convenient accessor of the date's `Calendar` components ordinality.
     *
     *  - parameter smaller: The smaller calendar component to access from the date
     *  - parameter larger: The larger calendar component to access from the date
     *
     *  - returns: The ordinal number of a smaller calendar component within a specified larger calendar component
     *
     */
    public func ordinality(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
        
        let calendar = Calendar.autoupdatingCurrent
        return calendar.ordinality(of: smaller, in: larger, for: self)
    }
    
    /**
     *  Use calendar components to determine how many units of a smaller component are inside 1 larger unit.
     *
     *  Ex. If used on a date in the month of February in a leap year (regardless of the day), the method would
     *  return 29 days.
     *
     *  - parameter smaller: The smaller calendar component to access from the date
     *  - parameter larger: The larger calendar component to access from the date
     *
     *  - returns: The number of smaller units required to equal in 1 larger unit, given the date called on
     *
     */
    public func unit(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
        
        let calendar = Calendar.autoupdatingCurrent
        var units = 1
        var unitRange: Range<Int>?
        if larger.hashValue < smaller.hashValue {
            for x in larger.hashValue..<smaller.hashValue {
                
                var stepLarger: Calendar.Component
                var stepSmaller: Calendar.Component
                
                switch (x) {
                case 0:
                    stepLarger = Calendar.Component.era
                    stepSmaller = Calendar.Component.year
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 1:
                    if smaller.hashValue > 2 {
                        break
                    } else {
                        stepLarger = Calendar.Component.year
                        stepSmaller = Calendar.Component.month
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 2:
                    if larger.hashValue < 2 {
                        if self.isInLeapYear {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 366))
                        } else {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 365))
                        }
                    } else {
                        stepLarger = Calendar.Component.month
                        stepSmaller = Calendar.Component.day
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 3:
                    stepLarger = Calendar.Component.day
                    stepSmaller = Calendar.Component.hour
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 4:
                    stepLarger = Calendar.Component.hour
                    stepSmaller = Calendar.Component.minute
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 5:
                    stepLarger = Calendar.Component.minute
                    stepSmaller = Calendar.Component.second
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                default:
                    return nil
                }
                
                if unitRange?.count != nil {
                    units *= (unitRange?.count)!
                }
            }
            return units
        }
        return nil
    }
    
    // MARK: - Components
    
    /**
     *  Convenience getter for the date's `era` component
     */
    public var era: Int {
        return component(.era)
    }
    
    /**
     *  Convenience getter for the date's `year` component
     */
    public var year: Int {
        return component(.year)
    }
    
    /**
     *  Convenience getter for the date's `month` component
     */
    public var month: Int {
        return component(.month)
    }
    
    /**
     *  Convenience getter for the date's `week` component
     */
    public var week: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `day` component
     */
    public var day: Int {
        return component(.day)
    }
    
    /**
     *  Convenience getter for the date's `hour` component
     */
    public var hour: Int {
        return component(.hour)
    }
    
    /**
     *  Convenience getter for the date's `minute` component
     */
    public var minute: Int {
        return component(.minute)
    }
    
    /**
     *  Convenience getter for the date's `second` component
     */
    public var second: Int {
        return component(.second)
    }
    
    /**
     *  Convenience getter for the date's `weekday` component
     */
    public var weekday: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `weekdayOrdinal` component
     */
    public var weekdayOrdinal: Int {
        return component(.weekdayOrdinal)
    }
    
    /**
     *  Convenience getter for the date's `quarter` component
     */
    public var quarter: Int {
        return component(.quarter)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    public var weekOfMonth: Int {
        return component(.weekOfMonth)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    public var weekOfYear: Int {
        return component(.weekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `yearForWeekOfYear` component
     */
    public var yearForWeekOfYear: Int {
        return component(.yearForWeekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `daysInMonth` component
     */
    public var daysInMonth: Int {
        let calendar = Calendar.autoupdatingCurrent
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    /**
     *  Returns how many days are in the year of the receiver.
     *
     *  @return Int
     */
    public var daysInYear: Int {
        let calendar = Calendar.autoupdatingCurrent
        let days = calendar.range(of: .day, in: .year, for: Date())
        return days!.count
    }
    
    // MARK: - Set Components
    
    /**
     *  Convenience setter for the date's `year` component
     */
    public mutating func year(_ year: Int) {
        self = Date(year: year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)!
    }
    
    /**
     *  Convenience setter for the date's `month` component
     */
    public mutating func month(_ month: Int) {
        self = Date(year: self.year, month: month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)!
    }
    
    /**
     *  Convenience setter for the date's `day` component
     */
    public mutating func day(_ day: Int) {
        self = Date(year: self.year, month: self.month, day: day, hour: self.hour, minute: self.minute, second: self.second)!
    }
    
    /**
     *  Convenience setter for the date's `hour` component
     */
    public mutating func hour(_ hour: Int) {
        self = Date(year: self.year, month: self.month, day: self.day, hour: hour, minute: self.minute, second: self.second)!
    }
    
    /**
     *  Convenience setter for the date's `minute` component
     */
    public mutating func minute(_ minute: Int) {
        self = Date(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: minute, second: self.second)!
    }
    
    /**
     *  Convenience setter for the date's `second` component
     */
    public mutating func second(_ second: Int) {
        self = Date(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: second)!
    }
    // MARK: - Bools
    
    /**
     *  Determine if date is in a leap year
     */
    public var isInLeapYear: Bool {
        let yearComponent = component(.year)
        
        if yearComponent % 400 == 0 {
            return true
        }
        if yearComponent % 100 == 0 {
            return false
        }
        if yearComponent % 4 == 0 {
            return true
        }
        return false
    }
    
    /**
     *  Determine if date is within the current day
     */
    public var isToday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInToday(self)
    }
    
    /**
     *  Determine if date is within the day tomorrow
     */
    public var isTomorrow: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
    }
    
    /**
     *  Determine if date is within yesterday
     */
    public var isYesterday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
    }
    
    /**
     *  Determine if date is in a weekend
     */
    public var isWeekend: Bool {
        if weekday == 7 || weekday == 1 {
            return true
        }
        return false
    }
}

