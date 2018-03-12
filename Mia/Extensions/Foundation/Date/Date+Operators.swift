// MARK: - *** Date Operators ***

extension Date {

    // MARK: *** Public Methods ***

    public static func +(lhs: Date, rhs: DateComponents) -> Date {

        return Calendar.current.date(byAdding: rhs, to: lhs)!
    }

    public static func -(lhs: Date, rhs: DateComponents) -> Date {

        return Calendar.current.date(byAdding: -rhs, to: lhs)!
    }
}

