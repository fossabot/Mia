import UIKit

public extension DeviceKit.Battery {

    /// The battery's current level.
    public static var level: Int {
        switch BatteryState() {
            case .full: return 100
            case .charging(let value): return value
            case .unplugged(let value): return value
        }
    }

    /// The state of the battery
    public static var state: BatteryState {
        return BatteryState()
    }

}

/// Battery State Enum
public enum BatteryState {

    case full
    case charging(Int)
    case unplugged(Int)

    /// Creates and returns a BatteryState from the device's current battery state.
    public init() {

        UIDevice.current.isBatteryMonitoringEnabled = true

        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)

        switch UIDevice.current.batteryState {
            case .charging: self = .charging(batteryLevel)
            case .unplugged:self = .unplugged(batteryLevel)
            default: self = .full
        }

        UIDevice.current.isBatteryMonitoringEnabled = false
    }

}

extension BatteryState: CustomStringConvertible {

    public var description: String {

        switch self {
            case .full: return "100%"
            case .charging(let batteryLevel): return "\(batteryLevel)% and charging"
            case .unplugged(let batteryLevel): return "\(batteryLevel)% and unplugged"
        }
    }

}
