import UIKit

// MARK: -
public extension Device {

    /// Determines whether device is an iPhone.
    public static var isPhone: Bool {

        return UIDevice.current.userInterfaceIdiom == .phone
    }

    /// Determines whether device is an iPad.
    public static var isPad: Bool {

        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    /// The name identifying the device (e.g. "Dennis' iPhone").
    public static var name: String {
        return UIDevice.current.name
    }

    /// The model of the device.
    public static var model: DeviceModel {
        return DeviceModel()
    }
    
    /// The model of the device.
    public static var type: DeviceType {
        return DeviceType()
    }

    /// The model string of the device.
    public static var modelString: String {
        return UIDevice.current.model
    }

    /// The model of the device as a localized string.
    public static var localizedModel: String {
        return UIDevice.current.localizedModel
    }
    
    /// The model identifier.
    public static var modelIdentifier: String {
        var sysinfo = utsname()
        uname(&sysinfo)
        let data = Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN))
        return String(bytes: data, encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    /// The name of the operating system running on the device represented by the receiver (e.g. "iPhone OS" or "tvOS").
    public static var systemName: String {
        return UIDevice.current.systemName
    }

    /// The name of the operating system running on the device represented by the receiver (e.g. "iPhone OS" or "tvOS").
    public static var firmware: String {
        return UIDevice.current.systemVersion
    }
}

