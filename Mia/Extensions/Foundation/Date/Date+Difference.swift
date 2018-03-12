import Foundation

extension Date {

    // MARK: - *** Time Since ***

    public func since(_ date: Date, in component: Date.Component) -> Int64 {

        switch component {
            case .second: return Int64(timeIntervalSince(date))
            case .minute: return Int64(timeIntervalSince(date) / Date.minuteInSeconds)
            case .hour: return Int64(timeIntervalSince(date) / Date.hourInSeconds)
            case .day: return ordinality(of: .day, in: .era, for: date, reversed: false)
            case .weekday: return ordinality(of: .weekday, in: .era, for: date, reversed: false)
            case .nthWeekday: return ordinality(of: .weekdayOrdinal, in: .era, for: date, reversed: false)
            case .week: return ordinality(of: .weekOfYear, in: .era, for: date, reversed: false)
            case .month: return ordinality(of: .month, in: .era, for: date, reversed: false)
            case .year: return ordinality(of: .year, in: .era, for: date, reversed: false)
        }
    }

    public func sinceNow(in component: Date.Component) -> Int64 {

        return since(Date(), in: component)
    }
    
    // MARK: - *** Time Until ***

    public func until(_ date: Date, in component: Date.Component) -> Int64 {

        switch component {
            case .second: return Int64(timeIntervalSince(date) * -1)
            case .minute: return Int64(timeIntervalSince(date) / -Date.minuteInSeconds)
            case .hour: return Int64(timeIntervalSince(date) / -Date.hourInSeconds)
            case .day: return ordinality(of: .day, in: .era, for: date, reversed: true)
            case .weekday: return ordinality(of: .weekday, in: .era, for: date, reversed: true)
            case .nthWeekday: return ordinality(of: .weekdayOrdinal, in: .era, for: date, reversed: true)
            case .week: return ordinality(of: .weekOfYear, in: .era, for: date, reversed: true)
            case .month: return ordinality(of: .month, in: .era, for: date, reversed: true)
            case .year: return ordinality(of: .year, in: .era, for: date, reversed: true)
        }
    }

    public func untilNow(in component: Date.Component) -> Int64 {

        return until(Date(), in: component)
    }
    
    // MARK: - *** Private / Helper Methods ***

    private func ordinality(of smaller: Calendar.Component, in larger: Calendar.Component, for date: Date, reversed: Bool) -> Int64 {

        let calendar = Calendar.current
        let end = calendar.ordinality(of: smaller, in: larger, for: self)!
        let start = calendar.ordinality(of: smaller, in: larger, for: date)!

        if reversed {
            return Int64(start - end)
        } else {
            return Int64(end - start)
        }
    }
}

