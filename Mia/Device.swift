import AdSupport
import Foundation
import SystemConfiguration.CaptiveNetwork
import UIKit


public struct Device {

    /// Returns the Devices current name
   public static  var name: String {
        return UIDevice.current.name
    }

    /// Returns the Devices current vendor identifier
    public static var vendorIdentifier: UUID? {
        return UIDevice.current.identifierForVendor!
    }

    /// Returns the Devices current battery level
    public static var batteryLevel: String {
        if UIDevice.current.isBatteryMonitoringEnabled == false {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
        return "\(UIDevice.current.batteryLevel * 100)"
    }

    public struct Network {

        /// Returns the name of the network the device is currently connected to.
        public static var networkSSID: String {

            let interfaces = CNCopySupportedInterfaces()
            if interfaces == nil {
                return ""
            }

            let interfacesArray = interfaces as! [String]
            if interfacesArray.count <= 0 {
                return ""
            }

            let interfaceName = interfacesArray[0] as String
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName as CFString)
            if unsafeInterfaceData == nil {
                return ""
            }

            let interfaceData = unsafeInterfaceData as! Dictionary<String, AnyObject>

            return interfaceData["SSID"] as! String
        }
    }

    public struct `Type` {

        /// Check to see if device is an iPhone
        ///
        /// - Returns: Returns a Boolean value that indicates whether the device is an iPhone.
        public static var isPhone: Bool {

            return UIDevice.current.userInterfaceIdiom == .phone
        }

        /// Check to see if device is an iPad
        ///
        /// - Returns: Returns a Bool value that indicates whether the device is an iPad.
        public static var isPad: Bool {

            return UIDevice.current.userInterfaceIdiom == .pad
        }

    }

    public struct Firmware {

        /// String representation of the current firmware.
        public static var currentVersion: String {
            return "\(UIDevice.current.systemVersion)"
        }

        /// Enum representation of iOS versions.
        public enum Firmwares: Float {
            /// iOS 5.0
            case five = 5.0

            /// iOS 6.0
            case six = 6.0

            /// iOS 7.0
            case seven = 7.0

            /// iOS 8.0
            case eight = 8.0

            /// iOS 9.0
            case nine = 9.0

            /// iOS 10.0
            case ten = 10.0

            /// iOS 11.0
            case eleven = 11.0
        }

        /// Check if device is on a specific firmware.
        ///
        /// - Parameter version: The firmware to check against.
        /// - Returns: Returns a Bool value the indicates the device is equal to the specified firmware.
        public static func isFirmware(_ firmware: Firmwares) -> Bool {

            return Float(UIDevice.current.systemVersion)! >= firmware.rawValue && Float(UIDevice.current.systemVersion)! < (firmware.rawValue + 1.0)
        }

        /// Check if device is on a specific firmware or later.
        ///
        /// - Parameter version: The firmware to check against.
        /// - Returns: Returns a Bool value the indicates the device is newer than the specified firmware.
        public static func isFirmwareOrLater(_ firmware: Firmwares) -> Bool {

            return Float(UIDevice.current.systemVersion)! >= firmware.rawValue
        }

        /// Check if device is earlier than a specific firmware.
        ///
        /// - Parameter version: The firmware to check against.
        /// - Returns: Returns a Bool value the indicates the device is older than the specified firmware.
        public static func isFirmwareOrEarlier(_ firmware: Firmwares) -> Bool {

            return Float(UIDevice.current.systemVersion)! < (firmware.rawValue + 1.0)
        }

    }

    public struct Size {

        /// Enum representation of various iOS screen sizes.
        public enum Sizes: CGFloat {
            case _3_5_inches = 480
            case _4_inches = 568
            case _4_7_inches = 667
            case _5_5_inches = 736

            var description: String {
                switch self {
                    case ._3_5_inches: return "3.5 Inches"
                    case ._4_inches:   return "4 Inches"
                    case ._4_7_inches: return "4.7 Inches"
                    case ._5_5_inches: return "5.5 Inches"
                }
            }

        }

        /// Get the current device's screen height.
        public static let screenHeight = UIScreen.main.bounds.size.height

        /// Get the current device's screen width.
        public static let screenWidth = UIScreen.main.bounds.size.width

        /// Check if device screen size is equal a specific screen size
        ///
        /// - Parameter size: The size to check against.
        /// - Returns: Returns a Bool value the indicates the screen size is equal to the specified size.
        public static func `is`(_ size: Sizes) -> Bool {

            return UIScreen.main.bounds.size.height == size.rawValue
        }

        /// Check if device screen size is larger or equal to a specific screen size
        ///
        /// - Parameter size: The size to check against.
        /// - Returns: Returns a Bool value the indicates the screen size is larger or equal to the specified size.
        public static func isLargerOrEqual(_ size: Sizes) -> Bool {

            return UIScreen.main.bounds.size.height >= size.rawValue
        }

        /// Check if device screen size is smaller or equal to a specific screen size
        ///
        /// - Parameter size: The size to check against.
        /// - Returns: Returns a Bool value the indicates the screen size is smaller or equal to the specified size.
        public static func isSmallerOrEqual(_ size: Sizes) -> Bool {

            return UIScreen.main.bounds.size.height <= size.rawValue
        }

    }

    public struct Setings {

        public enum PreferenceType: String {

            case about = "General&path=About"
            case accessibility = "General&path=ACCESSIBILITY"
            case airplaneMode = "AIRPLANE_MODE"
            case autolock = "General&path=AUTOLOCK"
            case cellularUsage = "General&path=USAGE/CELLULAR_USAGE"
            case brightness = "Brightness"
            case bluetooth = "Bluetooth"
            case dateAndTime = "General&path=DATE_AND_TIME"
            case facetime = "FACETIME"
            case general = "General"
            case keyboard = "General&path=Keyboard"
            case castle = "CASTLE"
            case storageAndBackup = "CASTLE&path=STORAGE_AND_BACKUP"
            case international = "General&path=INTERNATIONAL"
            case locationServices = "LOCATION_SERVICES"
            case accountSettings = "ACCOUNT_SETTINGS"
            case music = "MUSIC"
            case equalizer = "MUSIC&path=EQ"
            case volumeLimit = "MUSIC&path=VolumeLimit"
            case network = "General&path=Network"
            case nikePlusIPod = "NIKE_PLUS_IPOD"
            case notes = "NOTES"
            case notificationsId = "NOTIFICATIONS_ID"
            case phone = "Phone"
            case photos = "Photos"
            case managedConfigurationList = "General&path=ManagedConfigurationList"
            case reset = "General&path=Reset"
            case ringtone = "Sounds&path=Ringtone"
            case safari = "Safari"
            case assistant = "General&path=Assistant"
            case sounds = "Sounds"
            case softwareUpdateLink = "General&path=SOFTWARE_UPDATE_LINK"
            case store = "STORE"
            case twitter = "TWITTER"
            case facebook = "FACEBOOK"
            case usage = "General&path=USAGE"
            case video = "VIDEO"
            case vpn = "General&path=Network/VPN"
            case wallpaper = "Wallpaper"
            case wifi = "WIFI"
            case tethering = "INTERNET_TETHERING"
            case blocked = "Phone&path=Blocked"
            case doNotDisturb = "DO_NOT_DISTURB"

        }

        public static func open(_ preferenceType: PreferenceType) {

            let appPath = "App-Prefs:root=\(preferenceType.rawValue)"
            if let url = URL(string: appPath) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }

    }

}
