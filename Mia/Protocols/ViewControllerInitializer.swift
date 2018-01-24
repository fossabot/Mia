import Foundation
import UIKit

public protocol ViewControllerInitializer {

    static var storyboardIdentifier: String { get }

    static func instantiateFromStoryboard(name: String) -> Self

    static func instantiateFromNib() -> Self
}

extension UIViewController: ViewControllerInitializer {

    /// A string representation of the view controller's class.
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }

    /// Instantiates and returns the view controller loaded from a nib with the same name.
    /// - Important: Be sure to set file's owner class and connect the view outlet.
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
    /// - Parameter name: The name of the storyboard where the view controller resides.
    /// - Returns: The view controller.
    public static func instantiateFromStoryboard(name: String = "Main") -> Self {

        func instantiateFromStoryboard<T: UIViewController>(_: T.Type) -> T {

            let sb = UIStoryboard(name: name, bundle: nil)
            return sb.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
        }

        return instantiateFromStoryboard(self)
    }
}
