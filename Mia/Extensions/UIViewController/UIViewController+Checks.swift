
public extension UIViewController {

    public var isModal: Bool {
        return (self.presentingViewController != nil ||
                self.presentingViewController?.presentedViewController == self ||
                self.navigationController?.presentingViewController?.presentedViewController == self.navigationController ||
                self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self) != nil)
    }
}
