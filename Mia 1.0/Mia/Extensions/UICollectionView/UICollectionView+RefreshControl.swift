import UIKit


public extension UICollectionView {

    func setupRefreshControl(_ target: Any, _ action: Selector, _ useDarkColors: Bool = true) {

        for view in subviews {
            if view is UIRefreshControl {
                view.removeFromSuperview()
            }
        }

        let myString = "Reloading Data..."
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                            NSAttributedString.Key.foregroundColor: useDarkColors ? UIColor.lightText : UIColor.darkText
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
