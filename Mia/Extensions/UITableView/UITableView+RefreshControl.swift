import UIKit


public extension UITableView {

    func setupRefreshControl(_ target: Any, _ action: Selector, _ useDarkColors: Bool = true) {

        for view in subviews {
            if view is UIRefreshControl {
                view.removeFromSuperview()
            }
        }

        let myString = "Reloading Data..."
        let myAttribute = [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                            NSAttributedStringKey.foregroundColor: useDarkColors ? UIColor.lightText : UIColor.darkText
        ]

        let refresh = UIRefreshControl()
        refresh.addTarget(target, action: action, for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: myString, attributes: myAttribute)

        if #available(iOS 10.0, *) {
            refreshControl = refresh
        } else {
            addSubview(refresh)
        }

    }


    func endRefreshing() {

        reloadData()
        if #available(iOS 10.0, *) {
            refreshControl?.endRefreshing()
        } else {
            let subviews = subViews(type: UIRefreshControl.self)
            for subview in subviews {
                if let view = subview as? UIRefreshControl {
                    view.endRefreshing()
                }
            }
        }

    }

}
