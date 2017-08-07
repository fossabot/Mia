import UIKit


// MARK: - Aesthetics
public extension UITableView {

    func beautify(_ useDarkColors: Bool = true) {

        let view: UIView = UIView()
        backgroundColor = UIColor.clear
        self.tableFooterView = view

        backgroundColor = useDarkColors ? UIColor.black : UIColor.white
        backgroundView = UIView()
        self.reloadData()

    }

}


public enum SectionViewType {
    case button, label
}


// MARK: - Header / Footer
public extension UITableView {

    func viewForSection(_ label: String, _ target: Any, _ action: Selector, _ useDarkColors: Bool = true) -> UIView? {

        let viewHeader = self.viewForSection(label, useDarkColors)

        let button = UIButton(frame: viewHeader.frame)
        button.addTarget(target, action: action, for: .touchUpInside)
        viewHeader.addSubview(button)

        return viewHeader
    }

    func viewForSection(_ label: String, _ useDarkColors: Bool = true) -> UIView {

        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 30))
        viewHeader.autoresizingMask = [ .flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin ]

        let backgroundColor = (useDarkColors) ? UIColor.black : UIColor.white
        let textColor = (useDarkColors) ? UIColor.white : UIColor.black

        let viewLabel = UILabel(frame: viewHeader.frame)

        viewLabel.text = "   \(label)"
        viewLabel.backgroundColor = backgroundColor
        viewLabel.textColor = textColor;

        viewLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        viewLabel.textAlignment = .left

        viewHeader.addSubview(viewLabel)

        return viewHeader
    }

}


// MARK: - Refresh Control
public extension UITableView {

    func setupRefreshControl(_ target: Any, _ action: Selector, _ useDarkColors: Bool = true) {

        for view in subviews {
            if view is UIRefreshControl {
                view.removeFromSuperview()
            }
        }

        let myString = "Reloading Data..."
        let myAttribute = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 14.0)!, NSForegroundColorAttributeName: useDarkColors ? UIColor.lightText : UIColor.darkText ]

        let refresh = UIRefreshControl()
        refresh.addTarget(target, action: action, for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: myString, attributes: myAttribute)

        addSubview(refresh)

    }

    func endRefreshing() {

        reloadData()

        for view in subviews {
            if view is UIRefreshControl {
                (view as! UIRefreshControl).endRefreshing()
            }
        }
    }

}

