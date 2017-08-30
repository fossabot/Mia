import UIKit


public extension UITableViewCell {

    public func fixSeparatorInset() {

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
