// MARK: -
public struct Application {

    /// A UUID that may be used to uniquely identify the device, same across apps from a single vendor.
    public static var identifierForVendor: UUID? {
        return UIDevice.current.identifierForVendor!
    }
}
