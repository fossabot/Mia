import Foundation

extension Date {

    // MARK: - StartOf
    
    /**
     *  Return a date set to the start of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their minimum
     */
    public func start(of component: Calendar.Component) -> Date {
        
        var newDate = self;
        if component == .second {
            newDate.second(self.second)
        } else if component == .minute {
            newDate.second(0)
        } else if component == .hour {
            newDate.second(0)
            newDate.minute(0)
        } else if component == .day {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
        } else if component == .month {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
        } else if component == .year {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
            newDate.month(1)
        }
        return newDate
    }
    
    /**
     *  Return a date set to the end of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their maximum
     */
    public func end(of component: Calendar.Component) -> Date {
        
        var newDate = self;
        if component == .second {
            newDate.second(newDate.second + 1)
            newDate = newDate - 0.001
        } else if component == .minute {
            newDate.second(60)
            newDate = newDate - 0.001
        } else if component == .hour {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
        } else if component == .day {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
        } else if component == .month {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.day(newDate.daysInMonth)
        } else if component == .year {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.month(12)
            newDate.day(31)
        }
        
        return newDate
    }
    
    
    
    public func adding(years: Int) -> Date {

        var components = DateComponents()
        components.year = years
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(months: Int) -> Date {

        var components = DateComponents()
        components.month = months
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(weeks: Int) -> Date {

        var components = DateComponents()
        components.weekOfYear = weeks
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(days: Int) -> Date {

        var components = DateComponents()
        components.day = days
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(hours: Int) -> Date {

        var components = DateComponents()
        components.hour = hours
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(minutes: Int) -> Date {

        var components = DateComponents()
        components.minute = minutes
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func adding(seconds: Int) -> Date {

        var components = DateComponents()
        components.second = seconds
        return Calendar.current.date(byAdding: components, to: self)!
    }

    // MARK: - Subtracting components from date
    public func subtracting(years: Int) -> Date {

        var components = DateComponents()
        components.year = -years
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(months: Int) -> Date {

        var components = DateComponents()
        components.month = -months
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(weeks: Int) -> Date {

        var components = DateComponents()
        components.weekOfYear = -weeks
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(days: Int) -> Date {

        var components = DateComponents()
        components.day = -days
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(hours: Int) -> Date {

        var components = DateComponents()
        components.hour = -hours
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(minutes: Int) -> Date {

        var components = DateComponents()
        components.minute = -minutes
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func subtracting(seconds: Int) -> Date {

        var components = DateComponents()
        components.second = -seconds
        return Calendar.current.date(byAdding: components, to: self)!
    }
}
