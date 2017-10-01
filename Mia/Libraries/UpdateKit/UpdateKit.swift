import Alamofire

public typealias CheckBlock = () -> ()

private let versionKey: String = "Multinerd.UpdateKit.CurrentVersion"

// MARK: -
public struct UpdateKit {

    // MARK: Shared

    public static let shared = UpdateKit()

    // MARK: Configurations

    public struct Configurations {

        /// FOR DEBUGGING ONLY. Setting this to false will ensure the current version will not be saved.
        /// Use to test 'onFreshInstall' and 'onUpdate'
        public static var willSaveCurrentVersion: Bool = true {
            didSet {
                if willSaveCurrentVersion == false {
                    UserDefaults.standard.set(nil, forKey: versionKey)
                }
            }
        }

        /// Set the update type.
        public static var updateType: UpdateType = .normal

        /// Set the URL to check.
        public static var updateURL: String = ""

        fileprivate static var updateLink = "itms-services://?action=download-manifest&url=\(updateURL)"

    }

    private var currentVersion: String {
        return Application.Bundle.version.description
    }

    // MARK: Public Methods

    /// Check for updates OTA
    public func checkForUpdates() {

        if Configurations.updateURL.isEmpty {
            print("UpdateKit: 'Configurations.updateURL' is empty.")
            return
        }

        print("UpdateKit: Checking...")
        Alamofire.request(Configurations.updateURL).responsePropertyList(completionHandler: { response in
            switch response.result {

                case .failure(let error):
                    print("UpdateKit: Error \(error)")

                case .success(let value):
                    if PropertyListSerialization.propertyList(value, isValidFor: .xml) {
                        guard let dict = value as? [String: Any],
                              let items = dict["items"] as? [[String: Any]],
                              let meta = items[0]["metadata"] as? [String: Any],
                              let newVersion = meta["bundle-version"] as? String,
                              let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
                            print("UpdateKit: Failed to parse results.")
                            return
                        }

                        let updateAvailable = newVersion.compare(currentVersion, options: .numeric) == .orderedDescending

                        if updateAvailable {
                            print("UpdateKit: Update Available | New: \(newVersion) | Cur: \(currentVersion)")
                            DispatchQueue.main.async(execute: { self.showAlert() })
                        } else {
                            print("UpdateKit: No Updates Available")
                        }
                    }
            }
        })

    }

    /// Compares the last ran version with the current version.
    ///
    /// - Returns: A LastRunType value.
    public func checkLastAppVersion() -> LastRunType {

        if let lastSavedVersion = UserDefaults.standard.string(forKey: versionKey) {

            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedSame { return .noChanges }
            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedDescending { return .updated }
            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedAscending { return .downgraded }

            return .unknown

        } else {
            return .freshInstall
        }
    }

    /// Checks if the app was a fresh install.
    ///
    /// - Parameter completion: The callback block.
    public func onFreshInstall(_ completion: CheckBlock) {

        if self.checkLastAppVersion() == .freshInstall {
            if Configurations.willSaveCurrentVersion { saveCurrentVersion() }
            completion()
        }

    }

    /// Checks if the app was a updated.
    ///
    /// - Parameter completion: The callback block.
    public func onUpdate(_ completion: CheckBlock) {

        if self.checkLastAppVersion() == .updated {
            if Configurations.willSaveCurrentVersion { saveCurrentVersion() }
            completion()
        }
    }

    // MARK: Private Methods

    private init() {}

    private func showAlert(isAppStore: Bool = false) {

        let title: String = "New Update Available!"
        let message: String = "Would you like to install the new update?"
        let okButtonTitle: String = "Update Now!"
        let cancelButtonTitle: String = "Later..."

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { Void in
            guard let url = URL(string: Configurations.updateLink) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))

        if Configurations.updateType == .normal {
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }

        getTopMostController()?.present(alert, animated: true, completion: nil)
    }

    // MARK: Helpers

    private func saveCurrentVersion() {

        UserDefaults.standard.set(currentVersion, forKey: versionKey)
    }

}

// MARK: -
public enum UpdateType {

    /// Allow the user to ignore updates.
    case normal

    /// Force the user to update.
    case force

}

// MARK: -
public enum LastRunType {

    // The app has not changed.
    case noChanges

    /// The app is a fresh install.
    case freshInstall

    /// The app has been updated.
    case updated

    /// The app has been downgraded.
    case downgraded

    /// I cannot think of any reason this would be called.
    case unknown

}
