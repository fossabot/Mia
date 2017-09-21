import UIKit

public extension Container where Host: UIButton {

    func tap(_ action: @escaping Action) {

        let target = ButtonTarget(host: host, action: action)
        self.buttonTarget = target
    }
}

class ButtonTarget: NSObject {
    var action: Action?

    init(host: UIButton, action: @escaping Action) {

        super.init()

        self.action = action
        host.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
    }

    // MARK: - Action

    @objc
    func handleTap(_ sender: UIButton) {

        action?()
    }
}
