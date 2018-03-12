import Foundation

extension DateComponents {
    /// - returns: a date that occured "the receiver's components" before now.
    public var ago: Date {
        return self.until(Date())
    }

    /// - returns: the date that will occur once the receiver's components pass after now.
    public var fromNow: Date {
        return self.from(Date())
    }

    /// - returns: the date that will occur once the receiver's components pass after the provide date.
    public func from(_ date: Date) -> Date {

        return Calendar.current.date(byAdding: self, to: date)!
    }

    /// - returns: a date that occured "the receiver's components" before the provided date.
    public func until(_ date: Date) -> Date {

        return Calendar.current.date(byAdding: -self, to: date)!
    }

    /// An NSTimeInterval representing the delta, in seconds, of an NSDateComponents instance.
    public var timeInterval: TimeInterval? {
        let templateDate = Date()
        let finalDate = templateDate + self
        return finalDate.timeIntervalSince(templateDate)
    }
}

