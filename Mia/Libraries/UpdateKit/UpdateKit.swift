import Alamofire


private let queue = DispatchQueue(label: "Multinerd.UpdateKit")

public typealias CheckBlock = () -> ()


// MARK: - UpdateType
public enum UpdateType {

    /// Allow the user to ignore updates.
    case normal

    /// Force the user to update.
    case force

}


// MARK: - LastRunType
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


// MARK: - UpdateKit
public struct UpdateKit {

    // MARK: Shared

    public static let shared = UpdateKit()


    // MARK: Configurations

    public struct Configurations {

        /// FOR DEBUGGING ONLY. Setting this to false will ensure the current version will not be saved. Use to test 'onFreshInstall' and 'onUpdate'
        public static var willSaveCurrentVersion: Bool = true

        /// Set the update type.
        public static var updateType: UpdateType = .normal

        /// Set the URL to check.
        public static var updateURL: String = ""

        fileprivate static var updateLink = "itms-services://?action=download-manifest&url=\(updateURL)"

    }


    // MARK: Variables

    private let versionKey: String = "Multinerd.UpdateKit.CurrentVersion"


    // MARK: Init/Deinit

    private init() {}


    // MARK: Public Methods

    /// Check for updates OTA
    public func checkForUpdates() {

        if Configurations.updateURL.isEmpty {
            Rosewood.error("App.Update: 'Configurations.updateURL' is empty.")
            return
        }

        Rosewood.verbose("App.Update: Checking...")
        Alamofire.request(Configurations.updateURL).responsePropertyList(completionHandler: { response in
            switch response.result {

                case .failure(let error):
                    Rosewood.error(error)

                case .success(let value):
                    queue.async {
                        if PropertyListSerialization.propertyList(value, isValidFor: .xml) {
                            guard let dict = value as? [String: Any] else {
                                self.failedToParse()
                                return
                            }
                            guard let items = dict["items"] as? [[String: Any]] else {
                                self.failedToParse()
                                return
                            }
                            guard let meta = items[0]["metadata"] as? [String: Any] else {
                                self.failedToParse()
                                return
                            }
                            guard let newVersion = meta["bundle-version"] as? String else {
                                self.failedToParse()
                                return
                            }

                            guard let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
                                self.failedToParse()
                                return
                            }

                            let updateAvailable = newVersion.compare(currentVersion, options: .numeric) == .orderedDescending

                            if updateAvailable {
                                Rosewood.verbose("App.Update: Update Available | New: \(newVersion) | Cur: \(currentVersion)")
                                DispatchQueue.main.async(execute: { self.showAlert() })
                            } else {
                                Rosewood.verbose("App.Update: No Updates Available")
                            }
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

            if Application.currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedSame { return .noChanges }
            if Application.currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedDescending { return .updated }
            if Application.currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedAscending { return .downgraded }

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

        UserDefaults.standard.set(Application.currentVersion, forKey: versionKey)
    }


    private func failedToParse() {

        Rosewood.error("App.Update: Failed to parse results.")
    }

}
