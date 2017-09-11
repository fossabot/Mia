import UIKit

public extension DeviceKit.Application {

    /// The current app version
    public static var version: String {

        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    /// The current build number
    public static var build: String {

        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    /// The complete app version with build number (i.e. : "2.1.3 (343)")
    public static var fullAppVersion: String {

        return "\(version) (\(build))"
    }

}
