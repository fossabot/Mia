import UIKit

public extension UICollectionViewCell {

    /// Sets the cells `backgroundColor` and `contentView.backgroundColor` properties
    public var cBackgroundColor: UIColor {
        get {
            return backgroundColor!
        }

        set {

            backgroundColor = newValue
            contentView.backgroundColor = newValue

        }
    }

}
