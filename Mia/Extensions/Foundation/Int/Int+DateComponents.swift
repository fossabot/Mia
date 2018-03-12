//
//  Int+DateComponents.swift
//  Mia
//
//  Created by Michael Hedaitulla on 3/4/18.
//

import Foundation

extension Int {

    /// Create a `DateComponents` with `self` value set as nanoseconds
    public var nanoseconds: DateComponents {
        return self.toDateComponents(type: .nanosecond)
    }

    /// Create a `DateComponents` with `self` value set as seconds
    public var seconds: DateComponents {
        return self.toDateComponents(type: .second)
    }

    /// Create a `DateComponents` with `self` value set as minutes
    public var minutes: DateComponents {
        return self.toDateComponents(type: .minute)
    }

    /// Create a `DateComponents` with `self` value set as hours
    public var hours: DateComponents {
        return self.toDateComponents(type: .hour)
    }

    /// Create a `DateComponents` with `self` value set as days
    public var days: DateComponents {
        return self.toDateComponents(type: .day)
    }

    /// Create a `DateComponents` with `self` value set as weeks
    public var weeks: DateComponents {
        return (self * 7).days
    }

    /// Create a `DateComponents` with `self` value set as months
    public var months: DateComponents {
        return self.toDateComponents(type: .month)
    }

    /// Create a `DateComponents` with `self` value set as years
    public var years: DateComponents {
        return self.toDateComponents(type: .year)
    }

    /// Internal transformation function
    ///
    /// - parameter type: component to use
    ///
    /// - returns: return self value in form of `DateComponents` where given `Calendar.Component` has `self` as value
    internal func toDateComponents(type: Calendar.Component) -> DateComponents {

        var dateComponents = DateComponents()
        dateComponents.setValue(self, for: type)
        return dateComponents
    }
}

/// Singular variations of Int extension for DateComponents for readability
/// - note these properties behave exactly as their plural-named equivalents
public extension Int {
    public var nanosecond: DateComponents { return nanoseconds }
    public var second: DateComponents { return seconds }
    public var minute: DateComponents { return minutes }
    public var hour: DateComponents { return hours }
    public var day: DateComponents { return days }
    public var week: DateComponents { return weeks }
    public var month: DateComponents { return months }
    public var year: DateComponents { return years }
}
