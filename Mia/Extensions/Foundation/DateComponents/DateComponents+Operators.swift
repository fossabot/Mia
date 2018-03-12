// MARK: - *** DateComponents Operators ***

extension DateComponents {

    // MARK: - *** Public Methods ***

    public static prefix func -(rhs: DateComponents) -> DateComponents {

        var dateComponents = DateComponents()

        if let year = rhs.year { dateComponents.year = -year }
        if let month = rhs.month { dateComponents.month = -month }
        if let day = rhs.day { dateComponents.day = -day }
        if let hour = rhs.hour { dateComponents.hour = -hour }
        if let minute = rhs.minute { dateComponents.minute = -minute }
        if let second = rhs.second { dateComponents.second = -second }
        if let nanosecond = rhs.nanosecond { dateComponents.nanosecond = -nanosecond }

        return dateComponents
    }

    public static func +(lhs: DateComponents, rhs: DateComponents) -> DateComponents {

        return combineComponents(lhs: lhs, rhs: rhs, multiplier: 1)
    }

    public static func -(lhs: DateComponents, rhs: DateComponents) -> DateComponents {

        return combineComponents(lhs: lhs, rhs: rhs, multiplier: -1)
    }

    // MARK: - *** Private / Helper Methods ***

    private static func combineComponents(lhs: DateComponents, rhs: DateComponents, multiplier: Int) -> DateComponents {

        var comps = DateComponents()
        comps.second = (lhs.second ?? 0) + ((rhs.second ?? 0) * multiplier)
        comps.minute = (lhs.minute ?? 0) + ((rhs.minute ?? 0) * multiplier)
        comps.hour = (lhs.hour ?? 0) + ((rhs.hour ?? 0) * multiplier)
        comps.day = (lhs.day ?? 0) + ((rhs.day ?? 0) * multiplier)
        comps.month = (lhs.month ?? 0) + ((rhs.month ?? 0) * multiplier)
        comps.year = (lhs.year ?? 0) + ((rhs.year ?? 0) * multiplier)
        return comps
    }
}

