import Foundation

extension Date {

    public var hasTime: Bool {

        let components = self.components
        return !(components.hour! == 0 && components.minute! == 0 && components.second! == 0 && components.nanosecond! == 0)
    }

    public var timeOfDay: TimeOfDay {

        guard hasTime else { return .none }

        switch components.hour! {
            case 5..<12: return .morning
            case 12..<17:  return .afternoon
            case 17..<22: return .evening
            default: return .night
        }
    }
}
