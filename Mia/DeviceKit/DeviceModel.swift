import Foundation

// MARK: - *** Device Model ***
public enum DeviceModel {

    /// iPod Touch
    case iPodTouch5, iPodTouch6

    /// iPhone
    case iPhone4S
    case iPhone5, iPhone5C, iPhone5S
    case iPhone6, iPhone6Plus
    case iPhone6S, iPhone6SPlus
    case iPhoneSE
    case iPhone7, iPhone7Plus
    case iPhone8, iPhone8Plus
    case iPhoneX
    case iPhoneXS, iPhoneXS_Max
    case iPhoneXR

    /// iPad
    case iPad2, iPad3, iPad4, iPad5, iPad6
    case iPadAir, iPadAir2
    case iPadMini, iPadMini2, iPadMini3, iPadMini4
    case iPadPro9_7Inch
    case iPadPro10_5Inch
    case iPadPro11Inch
    case iPadPro12_9Inch, iPadPro12_9Inch2, iPadPro12_9Inch3

    /// Device is a Simulator
    indirect case simulator(DeviceModel)

    /// Device is not yet known (implemented)
    case unknown(String)

    // Current device
    public static let current = DeviceModel()

    /// Create and returns a DeviceModel from a model identifier.
    ///
    /// - Parameter identifier: The device identifier. Defaults to the current device's model identifier.
    private init(identifier: String = Device.modelIdentifier) {
        self = DeviceModel.mapToDevice(identifier: identifier)
    }
}

extension DeviceModel: CustomStringConvertible {

    public var description: String {

        let prefix = "[Device] "
        switch self {

            // iPod Touch
            case .iPodTouch5:          return prefix + "iPod Touch 5"
            case .iPodTouch6:          return prefix + "iPod Touch 6"

            // iPhone
            case .iPhone4S:             return prefix + "iPhone 4S"
            case .iPhone5:              return prefix + "iPhone 5"
            case .iPhone5C:             return prefix + "iPhone 5C"
            case .iPhone5S:             return prefix + "iPhone 5S"
            case .iPhone6:              return prefix + "iPhone 6"
            case .iPhone6Plus:          return prefix + "iPhone 6+"
            case .iPhone6S:             return prefix + "iPhone 6S"
            case .iPhone6SPlus:         return prefix + "iPhone 6S+"
            case .iPhone7:              return prefix + "iPhone 7"
            case .iPhone7Plus:          return prefix + "iPhone 7+"
            case .iPhone8:              return prefix + "iPhone 8+"
            case .iPhone8Plus:          return prefix + "iPhone 8+"
            case .iPhoneSE:             return prefix + "iPhone SE"
            case .iPhoneX:              return prefix + "iPhone X"
            case .iPhoneXS:             return prefix + "iPhone XS"
            case .iPhoneXS_Max:         return prefix + "iPhone XS Max"
            case .iPhoneXR:             return prefix + "iPhone XR"

            // iPad
            case .iPadMini:             return prefix + "iPad Mini"
            case .iPadMini2:            return prefix + "iPad Mini 2"
            case .iPadMini3:            return prefix + "iPad Mini 3"
            case .iPadMini4:            return prefix + "iPad Mini 4"
            case .iPad2:                return prefix + "iPad 2"
            case .iPad3:                return prefix + "iPad 3"
            case .iPad4:                return prefix + "iPad 4"
            case .iPad5:                return prefix + "iPad 5"
            case .iPad6:                return prefix + "iPad 6"
            case .iPadAir:              return prefix + "iPad Air"
            case .iPadAir2:             return prefix + "iPad Air 2"
            case .iPadPro9_7Inch:       return prefix + "iPad Pro 9.7"
            case .iPadPro10_5Inch:      return prefix + "iPad Pro 10.5"
            case .iPadPro11Inch:        return prefix + "iPad Pro 11"
            case .iPadPro12_9Inch:      return prefix + "iPad Pro 12.9"
            case .iPadPro12_9Inch2:     return prefix + "iPad Pro 12.9 (Second Gen)"
            case .iPadPro12_9Inch3:     return prefix + "iPad Pro 12.9 (Third Gen)"

            // Simulator
            case .simulator(let model): return "\(model) simulator"

            case .unknown(let device):  return prefix + "unknown: \(device)"
        }
    }
}

extension DeviceModel {

    /// Get the real `DeviceModel` from a `DeviceModel`.
    ///
    /// - Note:
    ///   If the device is a an iPhone8Plus simulator this function returns .iPhone8Plus (the real device).
    ///   If the parameter is a real device, this function just returns the passed parameter.
    ///
    /// - Parameter device: A `DeviceModel`
    /// - Returns: The underlying `DeviceModel`
    public static func realDevice(from device: DeviceModel) -> DeviceModel {
        if case let .simulator(model) = device {
            return model
        }
        return device
    }
}

extension DeviceModel {

    /// Map a device identifier to a `DeviceModel`
    ///
    /// - Parameter identifier: The device identifier.
    /// - Returns: A `DeviceModel`
    private static func mapToDevice(identifier: String) -> DeviceModel {
        switch identifier {

            // iPod Touch
            case "iPod5,1": return .iPodTouch5
            case "iPod7,1": return .iPodTouch6

            // iPhone
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
            case "iPhone10,1", "iPhone10,4": return .iPhone8
            case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
            case "iPhone10,3", "iPhone10,6": return .iPhoneX
            case "iPhone11,2": return .iPhoneXS
            case "iPhone11,4", "iPhone11,6": return .iPhoneXS_Max
            case "iPhone11,8": return .iPhoneXR

            // iPad
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
            case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
            case "iPad5,3", "iPad5,4": return .iPadAir2
            case "iPad6,11", "iPad6,12": return .iPad5
            case "iPad7,5", "iPad7,6": return .iPad6
            case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
            case "iPad5,1", "iPad5,2": return .iPadMini4
            case "iPad6,3", "iPad6,4": return .iPadPro9_7Inch
            case "iPad6,7", "iPad6,8": return .iPadPro12_9Inch
            case "iPad7,1", "iPad7,2": return .iPadPro12_9Inch2
            case "iPad7,3", "iPad7,4": return .iPadPro10_5Inch
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11Inch
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12_9Inch3

            // Simulator
            case "i386", "x86_64": return .simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))

            default: return .unknown(identifier)
        }
    }
}
