import Foundation


public struct Device {
    
    
    public struct `Type` {
        
        
        /// Check to see if device is an iPhone
        ///
        /// - Returns: Returns a Boolean value that indicates whether the device is an iPhone.
        public static func isPhone() -> Bool {
            
            return UIDevice.current.userInterfaceIdiom == .phone
        }
        
        
        /// Check to see if device is an iPad
        ///
        /// - Returns: Returns a Bool value that indicates whether the device is an iPad.
        public static func isPad() -> Bool {
            
            return UIDevice.current.userInterfaceIdiom == .pad
        }
        
    }
    
    
    public struct Firmware {
        
        
        /// String representation of the current firmware.
        public static var currentVersion: String {
            return "\(UIDevice.current.systemVersion.floatValue!)"
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
            
            return UIDevice.current.systemVersion.floatValue! >= firmware.rawValue && UIDevice.current.systemVersion.floatValue! < (firmware.rawValue + 1.0)
        }
        
        
        /// Check if device is on a specific firmware or later.
        ///
        /// - Parameter version: The firmware to check against.
        /// - Returns: Returns a Bool value the indicates the device is newer than the specified firmware.
        public static func isFirmwareOrLater(_ firmware: Firmwares) -> Bool {
            
            return UIDevice.current.systemVersion.floatValue! >= firmware.rawValue
        }
        
        
        /// Check if device is earlier than a specific firmware.
        ///
        /// - Parameter version: The firmware to check against.
        /// - Returns: Returns a Bool value the indicates the device is older than the specified firmware.
        public static func isFirmwareOrEarlier(_ firmware: Firmwares) -> Bool {
            
            return UIDevice.current.systemVersion.floatValue! < (firmware.rawValue + 1.0)
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
    
    
}
