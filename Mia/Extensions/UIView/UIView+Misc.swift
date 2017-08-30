import UIKit


public extension UIView {

    //https://stackoverflow.com/questions/32151637/swift-get-all-subviews-of-a-specific-type-and-add-to-an-array
    /// Get array of subviews of type 'T'
    ///
    /// - Parameter type: The object type.
    /// - Returns: Returns an array of objects of type 'T'
    public func subViews<T:UIView>(type: T.Type) -> [T] {

        var all = [ T ]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }

        return all
    }


    //https://stackoverflow.com/questions/32151637/swift-get-all-subviews-of-a-specific-type-and-add-to-an-array
    /// Recursively get array of subviews of type 'T'
    ///
    /// - Parameter type: The object type.
    /// - Returns: Returns an array of objects of type 'T'
    public func subViewsRecursive<T:UIView>(type: T.Type) -> [T] {

        var all = [ T ]()


        func getSubview(view: UIView) {

            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }


        getSubview(view: self)

        return all
    }


    /// Takes a screenshot of the current view.
    ///
    /// - Returns: Returns an UIImage of the screens current view.
    public func takeScreenshot() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
