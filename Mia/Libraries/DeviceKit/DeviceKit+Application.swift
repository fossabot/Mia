import UIKit

public extension DeviceKit.Application {

    public static var fullAppVersion: String {

        return "\(version) (\(build))"
    }

    public static var name: String {

        let displayName = getString(for: "CFBundleDisplayName")
        return !displayName.isEmpty ? displayName : getString(for: "CFBundleName")
    }

    public static var version: String {
        return getString(for: "CFBundleShortVersionString")
    }

    public static var build: String {
        return getString(for: "CFBundleVersion")
    }

    public static var executable: String {
        return getString(for: "CFBundleExecutable")
    }

    public static var bundle: String {
        return getString(for: "CFBundleIdentifier")
    }

    public static var schemes: [String] {
        guard let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [AnyObject],
              let urlType = urlTypes.first as? [String: AnyObject],
              let urlSchemes = urlType["CFBundleURLSchemes"] as? [String]
                else { return [] }

        return urlSchemes
    }

    public static var mainScheme: String? {
        return schemes.first
    }

}

private func getString(for key: String) -> String {

    return Bundle.main.infoDictionary?[key] as? String ?? ""
}


@available(*, deprecated, message: "Only works when launching from xCode")
public var isBeingDebugged: Bool {
    
    var info = kinfo_proc()
    var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var size = MemoryLayout<kinfo_proc>.stride
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    assert(junk == 0, "sysctl failed")
    return (info.kp_proc.p_flag & P_TRACED) != 0
}
