/*
 public class func storyboardClass() -> SalesOverviewView! {
 let sb = UIStoryboard(name: "Sales", bundle: nil)
 let vc = sb.instantiateViewController(withIdentifier: "SalesOverviewView") as! SalesOverviewView
 return vc
 }
 */
@available(*, deprecated, message: "Replaced with `ViewControllerInitializer`.")
public protocol StoryboardConvertible {
    @available(*, deprecated, message: "Replaced with `ViewControllerInitializer.instantiateFromStoryboard`.")
    static func storyboardInit() -> UIViewController
}


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
