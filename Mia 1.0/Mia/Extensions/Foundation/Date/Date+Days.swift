import Foundation

// MARK: - *** Days ***
extension Date {

    public func daysIn(_ component: Date.Component) -> Int {

        switch component {
            case .month: return unit(of: .day, in: .month)! 
            case .year: return unit(of: .day, in: .year)!
            default: fatalError("\(component) is not supported.")
        }
    }

    private func unit(of smaller: Calendar.Component, `in` larger: Calendar.Component) -> Int? {

        return Calendar.current.range(of: smaller, in: larger, for: self)?.count
    }
}
