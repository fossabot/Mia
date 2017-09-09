// MARK: - MNDeviceKit.Device Extension

extension MNDeviceKit.Hardware {


    /// Check to see if device is an iPhone.
    public static var isPhone: Bool {

        return UIDevice.current.userInterfaceIdiom == .phone
    }

    /// Check to see if device is an iPad.
    public static var isPad: Bool {

        return UIDevice.current.userInterfaceIdiom == .pad
    }

    // Get the device's model identifier.
    public static var deviceIdentifier: String {

        var systemInfo = utsname()
        uname(&systemInfo)

        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }


    /// Map device identifier to a `DeviceModel` object.
    ///
    /// - Parameter identifier: The identifier to map.
    /// - Returns: A `DeviceModel` object representing the device model.
    public static func mapToDeviceModel(identifier: String = MNDeviceKit.Hardware.deviceIdentifier) -> DeviceModel {

        switch identifier {

            case "i386", "x86_64": return .simulator(MNDeviceKit.Hardware.mapToDeviceModel(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))

            case "iPod1,1": return .iPodTouch1G
            case "iPod2,1": return .iPodTouch2G
            case "iPod3,1": return .iPodTouch3G
            case "iPod4,1": return .iPodTouch4G
            case "iPod5,1": return .iPodTouch5G
            case "iPod7,1": return .iPodTouch6G

            case "iPhone1,1": return .iPhone2G
            case "iPhone1,2": return .iPhone3G
            case "iPhone2,1": return .iPhone3GS

            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone4
            case "iPhone4,1": return .iPhone4S

            case "iPhone5,1", "iPhone5,2": return .iPhone5
            case "iPhone5,3", "iPhone5,4": return .iPhone5C
            case "iPhone6,1", "iPhone6,2": return .iPhone5S

            case "iPhone7,2": return .iPhone6
            case "iPhone7,1": return .iPhone6Plus

            case "iPhone8,1": return .iPhone6S
            case "iPhone8,2": return .iPhone6SPlus

            case "iPhone9,1", "iPhone9,3": return .iPhone7
            case "iPhone9,2", "iPhone9,4": return .iPhone7Plus

            case "iPhone8,4": return .iPhoneSE

            case "iPad1,1": return .iPad1
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
            case "iPad6,11", "iPad6,12": return .iPad5

            case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
            case "iPad5,1", "iPad5,2": return .iPadMini4

            case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
            case "iPad5,3", "iPad5,4": return .iPadAir2

            case "iPad6,3", "iPad6,4": return .iPadPro9Inch
            case "iPad7,3", "iPad7,4": return .iPadPro10Inch
            case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2": return .iPadPro12Inch

            default:
                print("Unknown Device Model: \(identifier)")
                return .unknown(identifier)
        }
    }

}


// MARK: - UIDevice Extension

public extension UIDevice {

    /// Check to see if device is an iPhone.
    public var isPhone: Bool {

        return MNDeviceKit.Hardware.isPhone
    }

    /// Check to see if device is an iPad.
    public var isPad: Bool {

        return MNDeviceKit.Hardware.isPad
    }

    // Get the device's model identifier.
    public var deviceIdentifier: String {

        return MNDeviceKit.Hardware.deviceIdentifier
    }

    /// Get the device's model type as a `DeviceModel` object.
    public var deviceModel: DeviceModel {

        return MNDeviceKit.Hardware.mapToDeviceModel()
    }

}
