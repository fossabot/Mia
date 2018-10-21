import Alamofire
/*
 public class func storyboardClass() -> SalesOverviewView! {
 let sb = UIStoryboard(name: "Sales", bundle: nil)
 let vc = sb.instantiateViewController(withIdentifier: "SalesOverviewView") as! SalesOverviewView
 return vc
 }
 */


// MARK: -

private let versionKey: String = "Multinerd.UpdateKit.CurrentVersion"




@available(*, deprecated, message: "Replaced with `UpdateKitWB`.")
public struct UpdateKit {
    
    // MARK: *** Shared ***
    
    public static let shared = UpdateKit()
    
    // MARK: *** Configurations ***
    
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
        
        /// Set the URL to check.
        public static var updateURL: String = ""
        
        fileprivate static var updateLink = "itms-services://?action=download-manifest&url=\(updateURL)"
    }
    
    // MARK: *** Properties ***
    
    private var currentVersion: String {
        return Application.BundleInfo.version.description
    }
    
    // MARK: *** Init/Deinit Methods ***
    
    private init() {}
    
    // MARK: *** Public Methods ***
    
    /// Check for updates OTA
    public func checkForUpdates() {
        
        if Configurations.updateURL.isEmpty {
            log(message: "'Configurations.updateURL' is empty.")
            return
        }
        
        log(message: "Checking for updates...")
        Alamofire.request(Configurations.updateURL).responsePropertyList(completionHandler: { response in
            switch response.result {
                
            case .failure(let error):
                self.log(message: "Error \(error)")
                
            case .success(let value):
                if PropertyListSerialization.propertyList(value, isValidFor: .xml) {
                    guard let dict = value as? [String: Any],
                        let items = dict["items"] as? [[String: Any]],
                        let meta = items[0]["metadata"] as? [String: Any],
                        let newVersion = meta["bundle-version"] as? String else {
                            self.log(message: "Failed to parse results.")
                            return
                    }
                    
                    let updateAvailable = newVersion.compare(self.currentVersion, options: .numeric) == .orderedDescending
                    
                    if updateAvailable {
                        self.log(message: "Update Available | New: \(newVersion) | Cur: \(self.currentVersion)")
                        DispatchQueue.main.async(execute: { self.showAlert() })
                    } else {
                        self.log(message: "No Updates Available")
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
    
    // MARK: *** Private Methods ***
    
    private func showAlert(isAppStore: Bool = false) {
        
        let title: String = "New Update Available!"
        let message: String = "Would you like to install the new update?"
        let okButtonTitle: String = "Update Now!"
        let cancelButtonTitle: String = "Later..."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { Void in
            guard let url = URL(string: Configurations.updateLink) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }))
        
        if Configurations.updateType == .normal {
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }
        
        getTopMostController()?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: *** Helper Methods ***
    
    private func saveCurrentVersion() {
        
        UserDefaults.standard.set(currentVersion, forKey: versionKey)
    }
    
    private func log(message: String) {
        
        if Configurations.isLoggingEnabled {
            Rosewood.Framework.print(framework: String(describing: self), message: message)
        }
    }
}


// MARK: -

@available(*, deprecated, message: "Replaced with `ViewControllerInitializer`.")
public protocol StoryboardConvertible {
    @available(*, deprecated, message: "Replaced with `ViewControllerInitializer.instantiateFromStoryboard`.")
    static func storyboardInit() -> UIViewController
}

// MARK: -

@available(*, deprecated, message: "Replaced with `ModalNavigationController`.")
public class ModalController: UINavigationController {
    
    @available(*, deprecated, message: "Replaced with `ModalNavigationController`.")
    public override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        let doneButton = UIBarButtonItem(image: Icon.WebView.dismiss, style: .plain, target: self, action: #selector(dismissViewController))
        doneButton.tintColor = .red
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            rootViewController.navigationItem.leftBarButtonItem = doneButton
        } else {
            rootViewController.navigationItem.rightBarButtonItem = doneButton
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    @objc func dismissViewController() {
        if let v = navigationController, self != v.viewControllers.first {
            v.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

// MARK: -

extension Date {
    
    @available(*, deprecated, message: "Replaced with `init?(fromString:format:)`.")
    public init?(dateTimeString: String) {
        
        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: dateTimeString, range: NSRange(location: 0, length: dateTimeString.utf16.count)) else {
            print("Failed to find a match for datetime: \(dateTimeString)")
            return nil
        }
        
        let dateString = (dateTimeString as NSString).substring(with: match.range(at: 1))     // Extract milliseconds
        let timeStamp = Double(dateString)! / 1000.0 // Convert to UNIX timestamp in seconds
        
        self.init(timeIntervalSince1970: timeStamp) // Create Date from timestamp
    }
}
