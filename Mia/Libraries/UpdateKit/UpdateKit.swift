import Alamofire


private let queue = DispatchQueue(label: "Multinerd.UpdateKit")

public typealias UpdateBlock = (Bool) -> ()
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

}

// MARK: - UpdateKit
public class UpdateKit {

    // MARK: Shared

    public static let shared = UpdateKit()

    // MARK: Configurations

    public struct Configurations {

        /// Set the update type.
        public static var updateType: UpdateType = .normal

        /// Set the URL to check. NOTE: incompatible with appstore links. TODO: appstore implementation.
        public static var updateURL: String = "https://dl.dropbox.com/s/jsne1fsvha446qv/cactusReportsV2.plist"

        fileprivate static var updateLink = "itms-services://?action=download-manifest&url=\(updateURL)"

    }

    // MARK: Variables

    private let versionKey: String = "Multinerd.UpdateKit.CurrentVersion"

    // MARK: Init/Deinit

    private init() {}

    // MARK: Public Methods

    /// Check for updates OTA
    public func checkForUpdates() {

        Rosewood.info("App.Update: Checking...")
        Alamofire.request(Configurations.updateURL).responsePropertyList(completionHandler: { response in
            switch response.result {

                case .failure(let error):
                    Rosewood.error(error)

                case .success(let value):
                    queue.async {
                        if PropertyListSerialization.propertyList(value, isValidFor: .xml) {
                            guard let dict = value as? [String: Any] else { return }
                            guard let items = dict["items"] as? [[String: Any]] else { return }
                            guard let meta = items[0]["metadata"] as? [String: Any] else { return }
                            guard let newVersion = meta["bundle-version"] as? String else { return }

                            guard let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else { return }

                            let updateAvailable = self.compare(current: currentVersion, new: newVersion)

                            if updateAvailable {
                                Rosewood.info("App.Update: Update Available \n\t\t New: \(newVersion) | Cur: \(currentVersion)")
                                DispatchQueue.main.async(execute: { self.showAlert() })
                            } else {
                                Rosewood.info("App.Update: No Updates Available")
                            }
                        }
                    }
            }
        })

    }

    public func onFreshInstall(_ completion: CheckBlock) {

        if checkLastAppVersion() == .freshInstall {
            completion()
        }
    }

    public func onUpdate(_ completion: @escaping CheckBlock) {

        if checkLastAppVersion() == .updated {
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
            UIApplication.shared.openURL(url)
        }))

        if Configurations.updateType == .normal {
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }

        getTopMostController()?.present(alert, animated: true, completion: nil)
    }

    // MARK: Helpers

    private func compare(current: String = Application.currentVersion, new: String) -> Bool {

        return new.compare(current, options: .numeric) == .orderedDescending
    }

    private func checkLastAppVersion() -> LastRunType {

        if let lastSavedVersion = UserDefaults.standard.string(forKey: versionKey) {
            if lastSavedVersion.isEqual(Application.currentVersion) {
                return .noChanges
            }

            saveCurrentVersion()
            return .updated

        } else {
            saveCurrentVersion()
            return .freshInstall
        }

    }

    private func saveCurrentVersion() {

        UserDefaults.standard.set(Application.currentVersion, forKey: versionKey)
        UserDefaults.standard.synchronize()
    }

}
