import UIKit

public extension DeviceKit.Device {

    /// Determines whether device is an iPhone.
    public static var isPhone: Bool {

        return UIDevice.current.userInterfaceIdiom == .phone
    }

    /// Determines whether device is an iPad.
    public static var isPad: Bool {

        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
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

    /// The model string of the device.
    public static var modelString: String {
        return UIDevice.current.model
    }

    /// The model of the device as a localized string.
    public static var localizedModel: String {
        return UIDevice.current.localizedModel
    }

    /// The name of the operating system running on the device represented by the receiver (e.g. "iPhone OS" or "tvOS").
    public static var systemName: String {
        return UIDevice.current.systemName
    }

}



/// Device Model Enum
public enum DeviceModel {

    indirect case simulator(DeviceModel)

    case iPodTouch1G, iPodTouch2G, iPodTouch3G, iPodTouch4G, iPodTouch5G, iPodTouch6G

    case iPhone2G, iPhone3G, iPhone3GS, iPhone4, iPhone4S
    case iPhone5, iPhone5C, iPhone5S, iPhoneSE
    case iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus, iPhone7, iPhone7Plus

    case iPad1, iPad2, iPad3, iPad4, iPad5
    case iPadAir, iPadAir2
    case iPadMini, iPadMini2, iPadMini3, iPadMini4
    case iPadPro9Inch, iPadPro10Inch, iPadPro12Inch

    case unknown(String)

    /// Create and returns a DeviceModel from a model identifier.
    ///
    /// - Parameter identifier: The identifier of the device.
    public init(identifier: String = modelIdentifier) {

        switch identifier {

            case "i386", "x86_64": self = .simulator(DeviceModel(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))

            case "iPod1,1": self = .iPodTouch1G
            case "iPod2,1": self = .iPodTouch2G
            case "iPod3,1": self = .iPodTouch3G
            case "iPod4,1": self = .iPodTouch4G
            case "iPod5,1": self = .iPodTouch5G
            case "iPod7,1": self = .iPodTouch6G

            case "iPhone1,1": self = .iPhone2G
            case "iPhone1,2": self = .iPhone3G
            case "iPhone2,1": self = .iPhone3GS

            case "iPhone3,1", "iPhone3,2", "iPhone3,3": self = .iPhone4
            case "iPhone4,1": self = .iPhone4S

            case "iPhone5,1", "iPhone5,2": self = .iPhone5
            case "iPhone5,3", "iPhone5,4": self = .iPhone5C
            case "iPhone6,1", "iPhone6,2": self = .iPhone5S

            case "iPhone7,2": self = .iPhone6
            case "iPhone7,1": self = .iPhone6Plus

            case "iPhone8,1": self = .iPhone6S
            case "iPhone8,2": self = .iPhone6SPlus

            case "iPhone9,1", "iPhone9,3": self = .iPhone7
            case "iPhone9,2", "iPhone9,4": self = .iPhone7Plus

            case "iPhone8,4": self = .iPhoneSE

            case "iPad1,1": self = .iPad1
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": self = .iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3": self = .iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6": self = .iPad4
            case "iPad6,11", "iPad6,12": self = .iPad5

            case "iPad2,5", "iPad2,6", "iPad2,7": self = .iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6": self = .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9": self = .iPadMini3
            case "iPad5,1", "iPad5,2": self = .iPadMini4

            case "iPad4,1", "iPad4,2", "iPad4,3": self = .iPadAir
            case "iPad5,3", "iPad5,4": self = .iPadAir2

            case "iPad6,3", "iPad6,4": self = .iPadPro9Inch
            case "iPad7,3", "iPad7,4": self = .iPadPro10Inch
            case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2": self = .iPadPro12Inch

            default: self = .unknown(identifier)
        }
    }

    public static var modelIdentifier: String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

}

extension DeviceModel: CustomStringConvertible {

    public var description: String {

        let prefix = "[Device] "
        switch self {
            case .simulator(let model): return "\(model) Simulator"

            case .iPodTouch1G: return prefix + "iPod Touch 1"
            case .iPodTouch2G: return prefix + "iPod Touch 2"
            case .iPodTouch3G: return prefix + "iPod Touch 3"
            case .iPodTouch4G: return prefix + "iPod Touch 4"
            case .iPodTouch5G: return prefix + "iPod Touch 5"
            case .iPodTouch6G: return prefix + "iPod Touch 6"

            case .iPhone2G: return prefix + "iPhone"
            case .iPhone3G: return prefix + "iPhone 3G"
            case .iPhone3GS: return prefix + "iPhone 3GS"
            case .iPhone4: return prefix + "iPhone 4"
            case .iPhone4S: return prefix + "iPhone 4s"
            case .iPhone5: return prefix + "iPhone 5"
            case .iPhone5C: return prefix + "iPhone 5C"
            case .iPhone5S: return prefix + "iPhone 5S"
            case .iPhone6: return prefix + "iPhone 6"
            case .iPhone6Plus: return prefix + "iPhone 6+"
            case .iPhone6S: return prefix + "iPhone 6S"
            case .iPhone6SPlus: return prefix + "iPhone 6S+"
            case .iPhone7: return prefix + "iPhone 7"
            case .iPhone7Plus: return prefix + "iPhone 7+"
            case .iPhoneSE: return prefix + "iPhone 5E"

            case .iPad1: return prefix + "iPad 1"
            case .iPad2: return prefix + "iPad 2"
            case .iPad3: return prefix + "iPad 3"
            case .iPad4: return prefix + "iPad 4"
            case .iPad5: return prefix + "iPad 5"

            case .iPadMini: return prefix + "iPad Mini"
            case .iPadMini2: return prefix + "iPad Mini 2"
            case .iPadMini3: return prefix + "iPad Mini 3"
            case .iPadMini4: return prefix + "iPad Mini 4"

            case .iPadAir: return prefix + "iPad Air"
            case .iPadAir2: return prefix + "iPad Air 2"

            case .iPadPro9Inch: return prefix + "iPad Pro 9.7"
            case .iPadPro10Inch: return prefix + "iPad Pro 10.5"
            case .iPadPro12Inch: return prefix + "iPad pro 12.9"

            case .unknown(let device): return prefix + "Unknown Device Model: \(device)"
        }
    }

}

extension DeviceModel: Equatable {

    public static func ==(lhs: DeviceModel, rhs: DeviceModel) -> Bool {

        return lhs.description == rhs.description
    }

}

//    public var screenSize: DeviceKit.Screen.ScreenSize {
//
//        switch self {
//            case .simulator(let model): return model.screenSize
//
//            case .iPodTouch1G: return ._3_5inch
//            case .iPodTouch2G: return ._3_5inch
//            case .iPodTouch3G: return ._3_5inch
//            case .iPodTouch4G: return ._3_5inch
//            case .iPodTouch5G: return ._4inch
//            case .iPodTouch6G: return ._4inch
//
//            case .iPhone2G: return ._3_5inch
//            case .iPhone3G: return ._3_5inch
//            case .iPhone3GS: return ._3_5inch
//            case .iPhone4: return ._3_5inch
//            case .iPhone4S: return ._3_5inch
//            case .iPhone5: return ._4inch
//            case .iPhone5C: return ._4inch
//            case .iPhone5S: return ._4inch
//            case .iPhone6: return ._4_7inch
//            case .iPhone6Plus: return ._5_5inch
//            case .iPhone6S: return ._4_7inch
//            case .iPhone6SPlus: return ._5_5inch
//            case .iPhone7: return ._4_7inch
//            case .iPhone7Plus: return ._5_5inch
//            case .iPhoneSE: return ._4inch
//
//            case .iPad1: return ._9_7inch
//            case .iPad2: return ._9_7inch
//            case .iPad3: return ._9_7inch
//            case .iPad4: return ._9_7inch
//            case .iPad5: return ._9_7inch
//
//            case .iPadMini: return ._7_9inch
//            case .iPadMini2: return ._7_9inch
//            case .iPadMini3: return ._7_9inch
//            case .iPadMini4: return ._7_9inch
//
//            case .iPadAir: return ._9_7inch
//            case .iPadAir2: return ._9_7inch
//
//            case .iPadPro9Inch: return ._9_7inch
//            case .iPadPro10Inch: return ._10_5inch
//            case .iPadPro12Inch: return ._12_9inch
//
//            case .unknown(_): return .unknown
//        }
//    }
