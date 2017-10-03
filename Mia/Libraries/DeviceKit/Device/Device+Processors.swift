// TODO: [DeviceKit] System uptime using calendar components.

// MARK: -
public extension Device.Processors {

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
