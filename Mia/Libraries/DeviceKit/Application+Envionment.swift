// MARK: -
extension Application {

    /// Determines whether the application was launched from Xcode
    @available(*, deprecated, message: "This code only runs if your launching the application from Xcode.")
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
