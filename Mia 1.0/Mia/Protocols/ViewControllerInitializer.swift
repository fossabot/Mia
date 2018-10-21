public protocol ViewControllerInitializer {

    /// A string representation of the view controller's class.
    static var storyboardIdentifier: String { get }

    /// Instantiates and returns the view controller loaded from a nib of the same name.
    ///
    /// - Returns: The view controller.
    static func instantiateFromNib() -> Self

    /// Instantiates and returns the view controller from a storyboard.
    ///
    /// - Parameter name: The name of the storyboard where the view controller resides.
    /// - Returns: The view controller.
    static func instantiateFromStoryboard(name: String) -> Self

    /// Instantiates and returns a modal navigation controller with the view controller as the `rootViewController`.
    ///
    /// - Parameter dismissType: The dismiss type.
    /// - Returns: The navigation controller.
    func embedInNavigationController(dismissType: DismissType) -> ModalNavigationController
}

extension UIViewController: ViewControllerInitializer {

    /// A string representation of the view controller's class.
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }

    /// Instantiates and returns the view controller loaded from a nib of the same name.
    ///
    /// # ⚠️ Important Notes: #
    /// 1. Set the file's owner class.
    /// 2. Connect the view outlet.
    ///
    /// If the view was created with '`Also create XIB file`' enabled, this should automatically be done by Xcode.
    ///
    /// # ⌨️ Usage Example: #
    /// ````swift
    /// let vc = MyViewController.instantiateFromNib()
    /// self.navigationController?.pushViewController(vc, animated: true)
    /// ````
    ///
    /// - Returns: The view controller.
    public static func instantiateFromNib() -> Self {

        func instantiateFromNib<T: UIViewController>(_: T.Type) -> T {

            return T.init(nibName: String(describing: T.self), bundle: Bundle.main)
        }

        return instantiateFromNib(self)
    }

    /// Instantiates and returns the view controller from a storyboard.
    ///
    /// # ⚠️ Important Notes: #
    /// 1. Set the class name as the view controller's storyboard Id.
    ///
    /// # Usage Example: #
    /// ````swift
    /// let vc = MyViewController.instantiateFromStoryboard(name: "MyStoryboard")
    /// self.navigationController?.pushViewController(vc, animated: true)
    /// ````
    ///
    /// - Parameter name: The name of the storyboard where the view controller resides.
    /// - Returns: The view controller.
    public static func instantiateFromStoryboard(name: String = "Main") -> Self {

        func instantiateFromStoryboard<T: UIViewController>(_: T.Type) -> T {

            let sb = UIStoryboard(name: name, bundle: nil)
            return sb.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
        }

        return instantiateFromStoryboard(self)
    }

    /// Instantiates and returns a modal navigation controller with the view controller as the `rootViewController`.
    ///
    /// # ⌨️ Usage Example: #
    /// ````swift
    /// let vc = MyViewController.instantiateFromStoryboard(name: "MyStoryboard")
    /// let nc = vc.embedInNavigationController()
    /// self.present(nc, animated: true, completion: nil)
    /// ````
    ///
    /// - Parameter dismissType: The dismiss type.
    /// - Returns: The navigation controller.
    public func embedInNavigationController(dismissType: DismissType) -> ModalNavigationController {

        switch dismissType {

            case .none: return ModalNavigationController(rootViewController: self, dismissWithButton: false, dismissWithSwipe: false)
            case .button: return ModalNavigationController(rootViewController: self, dismissWithButton: true, dismissWithSwipe: false)
            case .swipe: return ModalNavigationController(rootViewController: self, dismissWithButton: false, dismissWithSwipe: true)
            case .both: return ModalNavigationController(rootViewController: self, dismissWithButton: true, dismissWithSwipe: true)
        }
    }
}
