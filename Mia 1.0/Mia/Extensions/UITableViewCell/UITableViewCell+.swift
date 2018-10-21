import UIKit


public extension UITableViewCell {

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

    
    
    public func resetSeparatorInset() {

        if self.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            self.separatorInset = .zero
        }

        if self.responds(to: #selector(setter:UIView.preservesSuperviewLayoutMargins)) {
            self.preservesSuperviewLayoutMargins = false
        }

        if self.responds(to: #selector(setter:UIView.layoutMargins)) {
            self.layoutMargins = .zero
        }

    }
}
