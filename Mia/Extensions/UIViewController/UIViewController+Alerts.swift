import UIKit

public extension UIViewController {

    // MARK: Alert Style

    /// Present an UIAlertController with title, message and OK button
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message content of the alert
    public func showAlert(_ title: String?, message: String?) {

        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        showAlert(title, message: message, alertActions: [ cancelAction ])
    }


    /// Present an UIAlertController with title, message and custom UIAlertAction
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message content of the alert
    ///   - alertActions: Array of UIAlertActions
    public func showAlert(_ title: String?, message: String?, alertActions: [UIAlertAction]) {

        internal_showAlert(title, message: message, preferredStyle: .alert, alertActions: alertActions)
    }


    // MARK: Action Sheet Style

    /// Present an UIActionSheetController with title, message and OK button
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message content of the alert
    public func showActionSheet(_ title: String?, message: String?) {

        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        showActionSheet(title, message: message, alertActions: [ cancelAction ])
    }


    /// Present an UIAlertController with title, message and OK button
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message content of the alert
    ///   - alertActions: Array of UIAlertActions
    public func showActionSheet(_ title: String?, message: String?, alertActions: [UIAlertAction]) {

        internal_showAlert(title, message: message, preferredStyle: .actionSheet, alertActions: alertActions)
    }


    // MARK: Private

    private func internal_showAlert(_ title: String?, message: String?, preferredStyle: UIAlertControllerStyle, alertActions: [UIAlertAction]) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }

        self.present(alertController, animated: true, completion: nil)
    }

}
