//// MARK: Protocol definition
//
///// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
///// conform to this protocol when they are *not* NIB-based but only code-based
///// to be able to dequeue them in a type-safe manner
//public protocol Reusable: class {
//    /// The reuse identifier to use when registering and later dequeuing a reusable cell
//    static var reuseIdentifier: String { get }
//}
//
///// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
///// conform to this typealias when they *are* NIB-based
///// to be able to dequeue them in a type-safe manner
//public typealias NibReusable = Reusable & NibLoadable
//
//// MARK: - Default implementation
//
//public extension Reusable {
//    /// By default, use the name of the class as String for its reuseIdentifier
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}
//
//
//
//
//
//
//public protocol ViewControllerInitializer {
//    
//    /// A string representation of the view controller's class.
//    static var storyboardIdentifier: String { get }
//    
//    /// Instantiates and returns the view controller loaded from a nib of the same name.
//    ///
//    /// - Returns: The view controller.
//    static func instantiateFromNib() -> Self
//    
//    /// Instantiates and returns the view controller from a storyboard.
//    ///
//    /// - Parameter name: The name of the storyboard where the view controller resides.
//    /// - Returns: The view controller.
//    static func instantiateFromStoryboard(name: String) -> Self
//    
//}
//
//extension UIViewController: ViewControllerInitializer {
//    
//    /// A string representation of the view controller's class.
//    public static var storyboardIdentifier: String {
//        return String(describing: self)
//    }
//    
//    /// Instantiates and returns the view controller loaded from a nib of the same name.
//    ///
//    /// # ⚠️ Important Notes: #
//    /// 1. Set the file's owner class.
//    /// 2. Connect the view outlet.
//    ///
//    /// If the view was created with '`Also create XIB file`' enabled, this should automatically be done by Xcode.
//    ///
//    /// # ⌨️ Usage Example: #
//    /// ````swift
//    /// let vc = MyViewController.instantiateFromNib()
//    /// self.navigationController?.pushViewController(vc, animated: true)
//    /// ````
//    ///
//    /// - Returns: The view controller.
//    public static func instantiateFromNib() -> Self {
//        
//        func instantiateFromNib<T: UIViewController>(_: T.Type) -> T {
//            
//            return T.init(nibName: String(describing: T.self), bundle: Bundle.main)
//        }
//        
//        return instantiateFromNib(self)
//    }
//    
//    /// Instantiates and returns the view controller from a storyboard.
//    ///
//    /// # ⚠️ Important Notes: #
//    /// 1. Set the class name as the view controller's storyboard Id.
//    ///
//    /// # Usage Example: #
//    /// ````swift
//    /// let vc = MyViewController.instantiateFromStoryboard(name: "MyStoryboard")
//    /// self.navigationController?.pushViewController(vc, animated: true)
//    /// ````
//    ///
//    /// - Parameter name: The name of the storyboard where the view controller resides.
//    /// - Returns: The view controller.
//    public static func instantiateFromStoryboard(name: String = "Main") -> Self {
//        
//        func instantiateFromStoryboard<T: UIViewController>(_: T.Type) -> T {
//            
//            let sb = UIStoryboard(name: name, bundle: nil)
//            return sb.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
//        }
//        
//        return instantiateFromStoryboard(self)
//    }
//    
//}
