// MARK: -
public extension Device.Battery {

    /// The battery's current level.
    public var level: Int {

        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        UIDevice.current.isBatteryMonitoringEnabled = false

        return batteryLevel
    }

    /// The state of the battery
    public var state: UIDeviceBatteryState {

        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryState = UIDevice.current.batteryState
        UIDevice.current.isBatteryMonitoringEnabled = false

        return batteryState
    }
}
