import UIKit


public struct Application {

    public static var currentVersion: String {
        if let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return ver
        }
        return ""
    }

}
