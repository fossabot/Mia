import Foundation

// MARK: - *** Compare ***
extension Date {

    // MARK: *** Public Methods ***

    public func compare(_ type: Date.Comparators) -> Bool {

        switch type {
            case .isToday:     return compare(.isSameDay(as: Date()))
            case .isTomorrow:  return compare(.isSameDay(as: Date().adjust(.day, offset: 1)))
            case .isYesterday: return compare(.isSameDay(as: Date().adjust(.day, offset: -1)))
            case .isSameDay(let date):
                return components.era == date.components.era
                    && components.year == date.components.year
                    && components.month == date.components.month
                    && components.day == date.components.day

            case .isThisWeek: return compare(.isSameWeek(as: Date()))
            case .isNextWeek: return compare(.isSameWeek(as: Date().adjust(.week, offset: 1)))
            case .isLastWeek: return compare(.isSameWeek(as: Date().adjust(.week, offset: -1)))
            case .isSameWeek(let date):
                if components.weekOfYear! != date.components.weekOfYear! {
                    return false
                }
                // Ensure time interval is under 1 week
                return abs(self.timeIntervalSince(date)) < Date.weekInSeconds

            case .isThisMonth: return compare(.isSameMonth(as: Date()))
            case .isNextMonth: return compare(.isSameMonth(as: Date().adjust(.month, offset: 1)))
            case .isLastMonth: return compare(.isSameMonth(as: Date().adjust(.month, offset: -1)))
            case .isSameMonth(let date):
                return components.era == date.components.era
                    && components.year == date.components.year
                    && components.month == date.components.month

            case .isThisYear: return compare(.isSameYear(as: Date()))
            case .isNextYear: return compare(.isSameYear(as: Date().adjust(.year, offset: 1)))
            case .isLastYear: return compare(.isSameYear(as: Date().adjust(.year, offset: -1)))
            case .isSameYear(let date):
                return components.era == date.components.era
                    && components.year == date.components.year

            case .equals(let date): return self == date
            case .isBetween(let date1, let date2): return (min(date1, date2)...max(date1, date2)).contains(self)

            case .isLater(let date): return self > date
            case .isLaterOrEqual(let date): return self >= date
            case .isInTheFuture: return compare(.isLaterOrEqual(to: Date()))

            case .isEarlier(let date): return self < date
            case .isEarlierOrEqual(let date): return self <= date
            case .isInThePast: return compare(.isEarlierOrEqual(to: Date()))

            case .isWeekend: return Calendar.current.isDateInWeekend(self)
            case .isWeekday: return !compare(.isWeekend)

            case .isLeapYear: return daysIn(.year) == 366
        }
    }
}
