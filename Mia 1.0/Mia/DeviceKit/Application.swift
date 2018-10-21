#if os(OSX)
import Cocoa
#else
import UIKit
#endif

// MARK: - *** Application ***

public struct Application {

    /// A UUID that may be used to uniquely identify the device, same across apps from a single vendor.
    public static var identifierForVendor: UUID? {
        return UIDevice.current.identifierForVendor!
    }
}

// MARK: - *** Bundle ***

extension Application {

    public enum BundleInfo: String {

        case name = "CFBundleName"
        case displayName = "CFBundleDisplayName"
        case identifier = "CFBundleIdentifier"
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
        case executable = "CFBundleExecutable"

        /// Returns the app's product name if display name is not available.
        public static var dynamicName: BundleInfo {

            return BundleInfo.displayName.description.isEmpty ? BundleInfo.name : BundleInfo.displayName
        }
    }
}

extension Application.BundleInfo: CustomStringConvertible {

    public var description: String {
        return Bundle.main.infoDictionary?[self.rawValue] as? String ?? ""
    }
}


// MARK: - *** Environment ***

extension Application {

    /// Determines whether the application was launched from Xcode
    @available(*, deprecated, message: "This code will only execute when launching from Xcode.")
    public static var isBeingDebugged: Bool {

        var info = kinfo_proc()
        var mib: [Int32] = [ CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid() ]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }

    /// Determines whether the application is running tests
    public static var isRunningUnitTests: Bool {
        return NSClassFromString("XCTest") != nil
    }
}
