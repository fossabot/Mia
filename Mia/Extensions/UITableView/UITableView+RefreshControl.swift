import Foundation
import UIKit


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

        refreshControl = refresh
//        addSubview(refresh)

    }

    func endRefreshing() {

        reloadData()
        refreshControl?.endRefreshing()
//        for view in subviews {
//            if view is UIRefreshControl {
//                (view as! UIRefreshControl).endRefreshing()
//            }
//        }
    }

}
