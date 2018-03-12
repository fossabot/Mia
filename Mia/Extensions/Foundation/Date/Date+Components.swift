import Foundation

// MARK: - *** Components ***
extension Date {

    // MARK: *** Variables ***

    public var components: DateComponents {
        return Calendar.current.dateComponents(Calendar.Component.allValuesAsSet, from: self)
    }
    
    // MARK:  *** Public Methods ***

    public func component(_ type: Date.Component) -> Int? {

        let components = self.components
        switch type {
            case .second: return components.second
            case .minute: return components.minute
            case .hour: return components.hour
            case .day: return components.day
            case .weekday: return components.weekday
            case .nthWeekday: return components.weekdayOrdinal
            case .week: return components.weekOfYear
            case .month: return components.month
            case .year: return components.year
        }
    }
}

// MARK: - *** Calendar.Component Extension ***

extension Calendar.Component: EnumCollection {
}

