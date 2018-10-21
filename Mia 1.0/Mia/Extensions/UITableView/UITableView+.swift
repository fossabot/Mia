import UIKit


extension UITableView {

    /// Hide extra empty cells
    func hideEmptyCells() {

        self.tableFooterView = UIView(frame: .zero)
    }

}
