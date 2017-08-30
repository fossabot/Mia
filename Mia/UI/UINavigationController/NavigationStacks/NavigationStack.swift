import UIKit


/// UINavigationController with animation show lists of UIViewControllers
open class NavigationStack: UINavigationController {

    // MARK:  Delegate

    /// The delegate of the navigation controller object. Use this instead of delegate.
    weak open var stackDelegate: UINavigationControllerDelegate?

    // MARK: - Init/Deinit

    /// Initializes and returns a newly created navigation controller.
    ///
    /// - Parameter rootViewController: The root view controller of the navigation stack.
    public override init(rootViewController: UIViewController) {

        super.init(rootViewController: rootViewController)

        delegate = self
    }


    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        delegate = self
    }


    // MARK: - Variables

    /// A floating-point value that determines the rate of deceleration after the user lifts their finger.
    @IBInspectable open var decelerationRate: CGFloat = UIScrollViewDecelerationRateNormal

    /// The color to use for the background of the lists of UIViewControllers. Defaults to black.
    @IBInspectable open var bgColor: UIColor = .black

    /// The background view of the lists of UIViewControllers.
    open var backgroundView: UIView? = nil

    var overlay: Float = 0.8

    var scaleRatio: Float = 14.0

    var scaleValue: Float = 1.1

    fileprivate var screens = [ UIImage ]()

    // MARK: - Public Methods

    /// Show list of ViewControllers.
    public func showControllers() {

        if screens.count == 0 {
            return
        }

        var allScreens = screens
        allScreens.append(view.takeScreenshot())

        let collectionView = CollectionStackViewController(images: allScreens, delegate: self, overlay: overlay, scaleRatio: scaleRatio, scaleValue: scaleValue, bgColor: bgColor, bgView: backgroundView, decelerationRate: decelerationRate)
        present(collectionView, animated: false, completion: nil)
    }

}


// MARK: UINavigationControllerDelegate

extension NavigationStack: UINavigationControllerDelegate {

    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {

        stackDelegate?.navigationController?(navigationController, willShow: viewController, animated: animated)

        if navigationController.viewControllers.count > screens.count + 1 {
            screens.append(view.takeScreenshot())
        } else if navigationController.viewControllers.count == screens.count && screens.count > 0 {
            screens.removeLast()
        }
    }


    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        stackDelegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }


    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        return stackDelegate?.navigationController?(navigationController, interactionControllerFor: animationController)
    }


    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return stackDelegate?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }


    //  ???
    //  public func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> UIInterfaceOrientationMask {
    //    return stackDelegate?.navigationControllerSupportedInterfaceOrientations?(navigationController)
    //  }

    //  ???
    //  optional public func navigationControllerPreferredInterfaceOrientationForPresentation(navigationController: UINavigationController) -> UIInterfaceOrientation
    //

}


// MARK: CollectionStackViewControllerDelegate

extension NavigationStack: CollectionStackViewControllerDelegate {

    func controllerDidSelected(index: Int) {

        let newViewControllers = Array(viewControllers[0...index])
        setViewControllers(newViewControllers, animated: false)
        screens.removeSubrange(index..<screens.count)
    }
}
