import UIKit


// MARK: - Aesthetics
public extension UITableViewCell {

    func beautify(_ useDarkColors: Bool = true) {

        let textColor: UIColor = useDarkColors ? UIColor.white : UIColor.black
        for view in self.contentView.subviews {
            if view is UILabel {
                (view as! UILabel).textColor = textColor
            }
        }

        if self.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            self.separatorInset = .zero
        }
        if self.responds(to: #selector(setter:UIView.preservesSuperviewLayoutMargins)) {
            self.preservesSuperviewLayoutMargins = false
        }
        if self.responds(to: #selector(setter:UIView.layoutMargins)) {
            self.layoutMargins = .zero
        }

        let bgView: UIView = UIView()
        bgView.backgroundColor = useDarkColors ? UIColor.black : UIColor.white

        self.selectedBackgroundView = bgView
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }

}
