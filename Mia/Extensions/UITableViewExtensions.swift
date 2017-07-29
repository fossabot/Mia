import UIKit


// MARK: - Aesthetics
public extension UITableView {
    
    func beautify(_ useDarkColors: Bool = true) {
        
        let view: UIView = UIView()
        backgroundColor = UIColor.clear
        self.tableFooterView = view
        
        
        //        backgroundColor = useDarkColors ? UIColor.black : UIColor.white
        backgroundView = UIView()
        self.reloadData()
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

