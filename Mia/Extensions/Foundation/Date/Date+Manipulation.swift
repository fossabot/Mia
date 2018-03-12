import Foundation

extension Date {

    public func dateFor(_ type: Date.For) -> Date {

        switch type {

            case .nextDay(let day):
                var components = DateComponents()
                components.weekday = day.rawValue
                return Calendar.current.nextDate(after: self, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)!

            case .previousDay(let day):
                var components = DateComponents()
                components.weekday = day.rawValue
                return Calendar.current.nextDate(after: self, matching: components, matchingPolicy: .previousTimePreservingSmallerComponents)!

            case .nextWorkDay:
                var currentDate = dateFor(.next(.day))
                while currentDate.compare(.isWeekend) { currentDate = currentDate.dateFor(.next(.day)) }
                return currentDate

            case .previousWorkDay:
                var currentDate = dateFor(.previous(.day))
                while currentDate.compare(.isWeekend) { currentDate = currentDate.dateFor(.previous(.day)) }
                return currentDate

            case .next(let component):
                switch component {
                    case .year: return adjust(.year, offset: 1)
                    case .month: return adjust(.month, offset: 1)
                    case .week: return adjust(.week, offset: 1)
                    case .day: return adjust(.day, offset: 1)
                    default: fatalError("\(component) is not supported.")
                }

            case .previous(let component):
                switch component {
                    case .year: return adjust(.year, offset: -1)
                    case .month: return adjust(.month, offset: -1)
                    case .week: return adjust(.week, offset: -1)
                    case .day: return adjust(.day, offset: -1)
                    default: fatalError("\(component) is not supported.")
                }

            case .startOf(let component):
                switch component {
                    case .year:
                        return adjust(month: 1, day: 1, hour: 0, minute: 0, second: 0)

                    case .month:
                        return adjust(day: 1, hour: 0, minute: 0, second: 0)

                    case .week:
                        let calendar = Calendar.current
                        return calendar.date(from: calendar.dateComponents([ .yearForWeekOfYear, .weekOfYear ], from: self))!

                    case .day:
                        return adjust(hour: 0, minute: 0, second: 0)

                    case .hour:
                        return adjust(hour: nil, minute: 0, second: 0)

                    case .minute:
                        return adjust(hour: nil, minute: nil, second: 0)

                    case .second:
                        return adjust(hour: nil, minute: nil, second: components.second!)

                    default:
                        fatalError("\(type) is not supported.")
                }

            case .endOf(let component):
                switch component {

                    case .year:
                        return adjust(month: 12, day: 31, hour: 23, minute: 59, second: 60) - 1.second

                    case .month:
                        let month = (self.components.month ?? 0) + 1
                        return adjust(month: month, day: 1, hour: 0, minute: 0, second: 0) - 1.second

                    case .week:
                        let offset = 7 - components.weekday!
                        return adjust(.day, offset: offset).adjust(hour: 23, minute: 59, second: 60) - 1.second

                    case .day:
                        return adjust(hour: 23, minute: 59, second: 60) - 1.second

                    case .hour:
                        return adjust(hour: nil, minute: 59, second: 60) - 1.second

                    case .minute:
                        return adjust(hour: nil, minute: nil, second: 60) - 1.second

                    case .second:
                        return adjust(hour: nil, minute: nil, second: components.second!) - 1.second

                    default:
                        fatalError("\(type) is not supported.")
                }

            case .nearestMinute(let nearest):let minutes = (components.minute! + nearest / 2) / nearest * nearest
                return adjust(hour: nil, minute: minutes, second: nil)

            case .nearestHour(let nearest):let hours = (components.hour! + nearest / 2) / nearest * nearest
                return adjust(hour: hours, minute: 0, second: nil)
        }
    }

    // MARK: *** Adjust ***

    /// Create a new `Date` instance by changing components.
    ///
    /// - Parameters:
    ///   - component: The component to modify.
    ///   - offset: The offset value to use.
    /// - Returns: The created `Date` instance with the adjusted component.
    public func adjust(_ component: Date.Component, offset: Int) -> Date {

        var dateComp = DateComponents()
        switch component {
            case .second: dateComp.second = offset
            case .minute: dateComp.minute = offset
            case .hour: dateComp.hour = offset
            case .day: dateComp.day = offset
            case .weekday: dateComp.weekday = offset
            case .nthWeekday: dateComp.weekdayOrdinal = offset
            case .week: dateComp.weekOfYear = offset
            case .month: dateComp.month = offset
            case .year: dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }

    /// Create a new `Date` instance by changing the month, day, hour, minute and second component.
    ///
    /// - Parameters:
    ///   - month: The month value to use.
    ///   - day: The day value to use.
    ///   - hour: The hour value to use.
    ///   - minute: The minute value to use.
    ///   - second: The second value to use.
    /// - Returns: The created `Date` instance with the new values.
    public func adjust(month: Int? = nil, day: Int? = nil, hour: Int?, minute: Int?, second: Int?) -> Date {

        var comp = self.components
        if let month = month { comp.month = month }
        if let day = day { comp.day = day }
        if let hour = hour { comp.hour = hour }
        if let minute = minute { comp.minute = minute }
        if let second = second { comp.second = second }

        return Calendar.current.date(from: comp)!
    }

    // MARK: *** Truncate ***

    /// Creates a new `Date` instance by truncating components.
    ///
    /// - Parameter components: The components to truncated.
    /// - Returns: The created `Date` instance without the truncated values.
    public func truncate(_ component: Date.Component) -> Date {

        func truncated(_ components: [Calendar.Component]) -> Date {

            var dateComponents = self.components
            for component in components {
                switch component {
                    case .month: dateComponents.month = 1
                    case .day: dateComponents.day = 1
                    case .hour: dateComponents.hour = 0
                    case .minute: dateComponents.minute = 0
                    case .second: dateComponents.second = 0
                    case .nanosecond: dateComponents.nanosecond = 0
                    default: continue
                }
            }

            return Calendar.current.date(from: dateComponents)!
        }

        switch component {
            case .month: return truncated([ .month, .day, .hour, .minute, .second, .nanosecond ])
            case .day: return truncated([ .day, .hour, .minute, .second, .nanosecond ])
            case .hour: return truncated([ .hour, .minute, .second, .nanosecond ])
            case .minute: return truncated([ .minute, .second, .nanosecond ])
            case .second: return truncated([ .second, .nanosecond ])
            default:
                fatalError("\(component) is not yet supported.")
        }
    }
}

