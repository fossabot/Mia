// MARK: - *** Device Model ***
public enum DeviceModel: CustomStringConvertible {

    case unknown(String)
    indirect case simulator(DeviceModel)

    case iPodTouch5G, iPodTouch6G

    case iPhone5, iPhone5C, iPhone5S, iPhoneSE
    case iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus
    case iPhone7, iPhone7Plus, iPhone8, iPhone8Plus, iPhoneX

    case iPad5
    case iPadAir, iPadAir2
    case iPadMini2, iPadMini3, iPadMini4
    case iPadPro9Inch, iPadPro10Inch, iPadPro12Inch

    /// Create and returns a DeviceModel from a model identifier.
    ///
    /// - Parameter identifier: The device identifier. Defaults to the current device's model identifier.
    public init(identifier: String = Device.Device.modelIdentifier) {

        switch identifier {

            case "i386", "x86_64":
                let device = DeviceModel(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS")
                self = .simulator(device)

            case "iPod5,1":                         self = .iPodTouch5G
            case "iPod7,1":                         self = .iPodTouch6G

            case "iPhone5,1", "iPhone5,2":          self = .iPhone5
            case "iPhone5,3", "iPhone5,4":          self = .iPhone5C
            case "iPhone6,1", "iPhone6,2":          self = .iPhone5S
            case "iPhone7,2":                       self = .iPhone6
            case "iPhone7,1":                       self = .iPhone6Plus
            case "iPhone8,1":                       self = .iPhone6S
            case "iPhone8,2":                       self = .iPhone6SPlus
            case "iPhone8,4":                       self = .iPhoneSE
            case "iPhone9,1", "iPhone9,3":          self = .iPhone7
            case "iPhone9,2", "iPhone9,4":          self = .iPhone7Plus
            case "iPhone10,1", "iPhone10,4":        self = .iPhone8
            case "iPhone10,2", "iPhone10,5":        self = .iPhone8Plus
            case "iPhone10,3", "iPhone10,6":        self = .iPhoneX

            case "iPad4,4", "iPad4,5", "iPad4,6":   self = .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9":   self = .iPadMini3
            case "iPad5,1", "iPad5,2":              self = .iPadMini4
            case "iPad6,11", "iPad6,12":            self = .iPad5
            case "iPad4,1", "iPad4,2", "iPad4,3":   self = .iPadAir
            case "iPad5,3", "iPad5,4":              self = .iPadAir2
            case "iPad6,3", "iPad6,4":              self = .iPadPro9Inch
            case "iPad6,7", "iPad6,8":              self = .iPadPro12Inch
            case "iPad7,1", "iPad7,2":              self = .iPadPro12Inch
            case "iPad7,3", "iPad7,4":              self = .iPadPro10Inch

            default:                                self = .unknown(identifier)
        }
    }

    public var description: String {

        let prefix = "[Device] "
        switch self {

            case .unknown(let device):  return prefix + "unknown: \(device)"
            case .simulator(let model): return "\(model) simulator"

            case .iPodTouch5G:          return prefix + "iPod Touch 5"
            case .iPodTouch6G:          return prefix + "iPod Touch 6"

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

            case .iPadMini2:            return prefix + "iPad Mini 2"
            case .iPadMini3:            return prefix + "iPad Mini 3"
            case .iPadMini4:            return prefix + "iPad Mini 4"
            case .iPad5:                return prefix + "iPad 5"
            case .iPadAir:              return prefix + "iPad Air"
            case .iPadAir2:             return prefix + "iPad Air 2"
            case .iPadPro9Inch:         return prefix + "iPad Pro 9.7"
            case .iPadPro10Inch:        return prefix + "iPad Pro 10.5"
            case .iPadPro12Inch:        return prefix + "iPad Pro 12.9"
        }
    }
}

// MARK: - *** Device Type ***
public enum DeviceType: String {

    case unknown
    case simulator
    case iPhone
    case iPad
    case iPod

    /// Create and returns a DeviceType for the current device.
    public init() {

        let identifier: String = Device.Device.modelIdentifier
        if [ "i386", "x86_64" ].contains(identifier) {
            self = .simulator
        } else if identifier.contains("iPhone") {
            self = .iPhone
        } else if identifier.contains("iPad") {
            self = .iPad
        } else if identifier.contains("iPod") {
            self = .iPod
        } else {
            self = .unknown
        }
    }
}

// MARK: - *** Screen Size ***
public enum ScreenSize: CGFloat, CustomStringConvertible {

    case unknown = 0
    case screen3dot5 = 3.5
    case screen4dot0 = 4.0
    case screen4dot7 = 4.7
    case screen5dot5 = 5.5
    case screen5dot8 = 5.8
    case screen7dot9 = 7.9
    case screen9dot7 = 9.7
    case screen10dot5 = 10.5
    case screen12dot9 = 12.9

    /// Create and returns a ScreenSize for the current device.
    public init() {

        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(Double(UIScreen.main.bounds.width), Double(UIScreen.main.bounds.height))

        func iPad1024() -> ScreenSize {

            switch Device.Device.model {
                case .iPadMini2, .simulator(.iPadMini2), .iPadMini3, .simulator(.iPadMini3), .iPadMini4, .simulator(.iPadMini4): return .screen7dot9
                case .iPadPro10Inch, .simulator(.iPadPro10Inch): return .screen10dot5
                default: return .screen9dot7
            }
        }

        switch screenHeight {
            case 480: self = .screen3dot5
            case 568: self = .screen4dot0
            case 667: self = UIScreen.main.scale == 3.0 ? .screen5dot5 : .screen4dot7
            case 736: self = .screen5dot5
            case 812: self = .screen5dot8
            case 1024: self = iPad1024()
            case 1112: self = .screen10dot5
            case 1366: self = .screen12dot9
            default: self = .unknown
        }
    }

    public var description: String {
        switch self {
            case .screen3dot5: return "3.5 inches"
            case .screen4dot0: return "4.0 inches"
            case .screen4dot7: return "4.7 inches"
            case .screen5dot5: return "5.5 inches"
            case .screen5dot8: return "5.8 inches"
            case .screen7dot9: return "7.9 inches"
            case .screen9dot7: return "9.7 inches"
            case .screen10dot5: return "10.5 inches"
            case .screen12dot9: return "12.9 inches"
            case .unknown: return "unknown"
        }
    }
}

// MARK: - *** Screen Family ***

public enum ScreenFamily: String {

    case unknown
    case old
    case small
    case medium
    case big

    /// Create and returns a ScreenFamily for the current device.
    public init() {

        let size: ScreenSize = Device.Screen.size
        switch size {
            case .screen3dot5, .screen4dot0: self = .old
            case .screen4dot7: self = .small
            case .screen5dot5, .screen5dot8, .screen7dot9: self = .medium
            case .screen9dot7, .screen10dot5, .screen12dot9: self = .big
            default: self = .unknown
        }
    }
}

// MARK: - *** Screen Scale ***
public enum ScreenScale: CGFloat {

    case unknown = 0.0
    case x1 = 1.0
    case x2 = 2.0
    case x3 = 3.0

    /// Create and returns a ScreenScale for the current device.
    public init() {

        let scale = UIScreen.main.scale
        switch scale {
            case 1.0: self = .x1
            case 2.0: self = .x2
            case 3.0: self = .x3
            default: self = .unknown
        }
    }
}

/////

// MARK: - Protocol Extensions

extension DeviceModel: Equatable {

    public static func ==(lhs: DeviceModel, rhs: DeviceModel) -> Bool {

        return lhs.description == rhs.description
    }
}

// MARK: -


extension ScreenSize: Comparable {

    public static func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

extension ScreenSize: Equatable {

    public static func ==(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: -

extension ScreenScale: Comparable {

    public static func <(lhs: ScreenScale, rhs: ScreenScale) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

extension ScreenScale: Equatable {

    public static func ==(lhs: ScreenScale, rhs: ScreenScale) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}
