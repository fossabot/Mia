import Foundation
import CoreGraphics
#if os(iOS) || os(tvOS)
import UIKit.UIGeometry
#endif

public protocol Then {
}

public extension Then where Self: Any {

    /// Makes it easier to set properties with closures after copying the value types.
    ///
    /// # ⌨️ Usage Example: #
    /// Replace the following code:
    /// ````swift
    /// let newFrame = oldFrame
    /// newFrame.size.width = 200
    /// newFrame.size.height = 100
    /// ````
    /// with
    /// ````swift
    /// let newFrame = oldFrame.with {
    ///     $0.size.width = 200
    ///     $0.size.height = 100
    /// }
    /// ````
    ///
    /// - Parameter block: The block to make any property changes
    /// - Returns: Returns a cloned object with new values set
    /// - Throws: Rethrows any exception thrown within the block
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {

        var copy = self
        try block(&copy)
        return copy
    }

    /// Makes it easier to execute code with closures.
    ///
    /// # ⌨️ Usage Example: #
    /// ````swift
    /// UserDefaults.standard.do {
    ///     $0.set("multinerd", forKey: "username")
    ///     $0.set("mike@multinerd.io", forKey: "email")
    /// }
    /// ````
    /// - Parameter block: The block to reuse the singleton
    /// - Throws: Rethrows any exception thrown within the block
    public func `do`(_ block: (Self) throws -> Void) rethrows {

        try block(self)
    }

}

public extension Then where Self: AnyObject {

    /// Makes it easier to set properties with closures just after initializing.
    /// # ⌨️ Usage Example: #
    /// ````swift
    /// let label = UILabel().then {
    ///     $0.text = "Hello, World!"
    ///     $0.textAlignment = .center
    ///     $0.textColor = .black
    /// }
    /// ````
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {

        try block(self)
        return self
    }

}

extension NSObject: Then {
}

extension CGPoint: Then {
}

extension CGRect: Then {
}

extension CGSize: Then {
}

extension CGVector: Then {
}

#if os(iOS) || os(tvOS)
extension UIEdgeInsets: Then {
}

extension UIOffset: Then {
}

extension UIRectEdge: Then {
}
#endif
