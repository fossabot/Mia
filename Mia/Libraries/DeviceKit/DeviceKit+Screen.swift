import UIKit

public extension DeviceKit.Screen {

    /// Determines whether the screen is retina
    public static var isRetina: Bool {
        return UIScreen.main.scale > 1.0
    }

    /// Determines whether the screen is zoomed
    public static var isZoomed: Bool {
        if UIScreen.main.scale == 3.0 {
            return UIScreen.main.nativeScale > 2.7
        } else {
            return UIScreen.main.nativeScale > UIScreen.main.scale
        }
    }

    /// Determines whether the screen is being mirrored
    public static var isScreenMirrored: Bool {

        if UIScreen.main.mirrored != nil {
            return true
        }

        return false
    }

    /// The current brightness
    public static var brightness: CGFloat {

        return UIScreen.main.brightness
    }

    /// The current orientation
    public static var orientation: UIDeviceOrientation {

        return UIDevice.current.orientation
    }

    /// The current state of the battery
    public static var size: ScreenSize {
        return ScreenSize()
    }
    
    public static var pixelSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let scale = UIScreen.main.scale
        
        return CGSize(width: screenSize.width * scale,
                      height: screenSize.height * scale)
    }

}

/// Screen Size Enum
public enum ScreenSize: Double {

    case unknown = 0
    case screen3_5 = 3.5
    case screen4 = 4.0
    case screen4_7 = 4.7
    case screen5_5 = 5.5
    case screen7_9 = 7.9
    case screen9_7 = 9.7
    case screen10_5 = 10.5
    case screen12_9 = 12.9

    /// Creates and returns a ScreenSize from the current device's screen height
    public init() {

        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)

        switch screenHeight {
            case 480: self = .screen3_5
            case 568: self = .screen4
            case 667: self = UIScreen.main.scale == 3.0 ? .screen5_5 : .screen4_7
            case 736: self = .screen5_5
            case 1024: self = ScreenSize.ipad1024()
            case 1112: self = .screen10_5
            case 1366: self = .screen12_9
            default: self = .unknown
        }
    }

    private static func ipad1024() -> ScreenSize {

        switch DeviceKit.Device.model {
            case .iPadMini, .simulator(.iPadMini), .iPadMini2, .simulator(.iPadMini2), .iPadMini3, .simulator(.iPadMini3), .iPadMini4, .simulator(.iPadMini4): return .screen7_9
            case .iPadPro10Inch, .simulator(.iPadPro10Inch): return .screen10_5
            default: return .screen9_7
        }
    }

}

extension ScreenSize: CustomStringConvertible {

    public var description: String {
        switch self {
            case .screen3_5: return "3.5 Inches"
            case .screen4:   return "4.0 Inches"
            case .screen4_7: return "4.7 Inches"
            case .screen5_5: return "5.5 Inches"
            case .screen7_9: return "7.9 Inches"
            case .screen9_7: return "9.7 Inches"
            case .screen10_5: return "10.5 Inches"
            case .screen12_9: return "12.9 Inches"
            case .unknown:  return "Unknown Device Size"
        }
    }

}

extension ScreenSize: Comparable {

    public static func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }

    public static func ==(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }

}
