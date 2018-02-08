import Alamofire

private let versionKey: String = "Multinerd.UpdateKitWB.CurrentVersion"

// This class has a very specific use case. Not for public use.
public struct UpdateKitWB {

    // MARK: - *** Shared ***

    public static let shared = UpdateKitWB()

    // MARK: - *** Configurations ***

    public struct Configurations {

        public static var isLoggingEnabled: Bool = true

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
    }

    // MARK: - *** Properties ***

    private var currentVersion: String {
        return Application.BundleInfo.version.description
    }

    private var bundleIdentifier: String {
        return Application.BundleInfo.identifier.description
    }

    // MARK: - *** Init/Deinit Methods ***
    
    private init() {}

    // MARK: - *** Public Methods ***

    /// Check for updates OTA
    public func checkForUpdates(url: String) {

        let postHeaders: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded" ]
        let encoding: JSONEncoding = JSONEncoding.default
        let parameters: [String: Any] = [ "BundleId": bundleIdentifier, "Version": currentVersion ]

        let oldDecodeDate = CodableKit.Configurations.Decoding.dateStrategy
        CodableKit.Configurations.Decoding.dateStrategy = .datetimeDotNet
        
        log(message: "Checking for updates...")
        Alamofire.request(url, method: .post, parameters: parameters, encoding: encoding, headers: postHeaders).responseData { (response) in
            switch response.result {

                case .failure(let error):
                    self.log(message: "Error \(error)")

                case .success(let value):
                    if !value.isEmpty, let entities = AppStore_Apps_Version.decode(data: value) {
                        self.log(message: "Update Available | New: \(entities.versionString) | Cur: \(self.currentVersion)")
                        DispatchQueue.main.async(execute: { self.showAlert(url: "itms-services://?action=download-manifest&url=\(entities.PList_URL)") })
                    } else {
                        self.log(message: "No Updates Available")
                    }
                
                    CodableKit.Configurations.Decoding.dateStrategy = oldDecodeDate
            }
        }
    }

//    /// Compares the last ran version with the current version.
//    ///
//    /// - Returns: A LastRunType value.
//    public func checkLastAppVersion() -> LastRunType {
//
//        if let lastSavedVersion = UserDefaults.standard.string(forKey: versionKey) {
//
//            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedSame { return .noChanges }
//            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedDescending { return .updated }
//            if currentVersion.compare(lastSavedVersion, options: .numeric) == .orderedAscending { return .downgraded }
//
//            return .unknown
//        } else {
//            return .freshInstall
//        }
//    }
//
//    /// Checks if the app was a fresh install.
//    ///
//    /// - Parameter completion: The callback block.
//    public func onFreshInstall(_ completion: CheckBlock) {
//
//        if self.checkLastAppVersion() == .freshInstall {
//            if Configurations.willSaveCurrentVersion { saveCurrentVersion() }
//            completion()
//        }
//    }
//
//    /// Checks if the app was a updated.
//    ///
//    /// - Parameter completion: The callback block.
//    public func onUpdate(_ completion: CheckBlock) {
//
//        if self.checkLastAppVersion() == .updated {
//            if Configurations.willSaveCurrentVersion { saveCurrentVersion() }
//            completion()
//        }
//    }

    // MARK: - *** Private Methods ***

    private func showAlert(url: String) {

        let title: String = "New Update Available!"
        let message: String = "Would you like to install the new update?"
        let okButtonTitle: String = "Update Now!"
        let cancelButtonTitle: String = "Later..."

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { Void in
            guard let url = URL(string: self.createDownloadLink(url: url)) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))

        if Configurations.updateType == .normal {
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }

        getTopMostController()?.present(alert, animated: true, completion: nil)
    }

    // MARK: - *** Helper Methods ***

    private func saveCurrentVersion() {

        UserDefaults.standard.set(currentVersion, forKey: versionKey)
    }

    private func createDownloadLink(url: String) -> String {
        let urlPrefix = "https://s3.amazonaws.com/cactusappstore/"
        var urlPath = url.replacingOccurrences(of: urlPrefix, with: "")
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let newUrl = "\(urlPrefix)\(urlPath)"
        return "itms-services://?action=download-manifest&url=\(newUrl)"
    }
    
    private func log(message: String) {

        if Configurations.isLoggingEnabled {
            Rosewood.Framework.print(framework: String(describing: self), message: message)
        }
    }
}


