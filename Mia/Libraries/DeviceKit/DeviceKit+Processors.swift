import UIKit

// TODO: [DeviceKit] System uptime using calendar components.

public extension DeviceKit.Processors {

    /// Determines whether the low power mode is currently enabled
    @available(iOS 9.0, *)
    public static var isLowPowerModeEnabled: Bool {

        return ProcessInfo().isLowPowerModeEnabled
    }

    /// Number of processors
    public static var processorsNumber: Int {

        return ProcessInfo().processorCount
    }

    /// Number of active processors
    public static var activeProcessorsNumber: Int {

        return ProcessInfo().activeProcessorCount
    }

    /// The current boot time expressed in seconds
    public static var upTime: TimeInterval {

        return ProcessInfo().systemUptime
    }

    /// Physical memory of the device
    public static var physicalMemory: Int64 {

        return Int64(ProcessInfo().physicalMemory)
    }

}
