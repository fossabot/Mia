import UIKit

public extension Container where Host: UIBarButtonItem {

    func tap(_ action: @escaping Action) {

        let target = BarButtonItemTarget(host: host, action: action)

        self.barButtonItemTarget = target
    }
}

class BarButtonItemTarget: NSObject {
    var action: Action?

    init(host: UIBarButtonItem, action: @escaping Action) {

        super.init()

        self.action = action
        host.target = self
        host.action = #selector(handleTap(_:))
    }

    // MARK: - Action

    @objc
    func handleTap(_ sender: UIBarButtonItem) {

        action?()
    }
}
