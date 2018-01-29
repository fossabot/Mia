public enum DismissType {
    case none
    case button
    case swipe
    case both
}

/// A dismissible UINavigationController subclass.
public class ModalNavigationController: UINavigationController {

    // MARK: *** Configurations ***

    struct Configurations {
        static var dragThreshold: CGFloat = 200
    }

    // MARK: *** Properties ***
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    // MARK: *** Init/Deinit Methods ***

    public init(rootViewController: UIViewController, dismissWithButton: Bool, dismissWithSwipe: Bool) {

        super.init(rootViewController: rootViewController)

        if dismissWithButton {
            setupButton(on: rootViewController)
        }

        if dismissWithSwipe {
            setupSwipe()
        }
    }

    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    // MARK: *** Setup ***

    private func setupButton(on viewController: UIViewController) {

        let doneButton = UIBarButtonItem(image: Icon.close, style: .done, target: self, action: #selector(dismissViewController(_:)))
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            viewController.navigationItem.leftBarButtonItem = doneButton
        } else {
            viewController.navigationItem.rightBarButtonItem = doneButton
        }
    }

    private func setupSwipe() {

        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .coverVertical

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        gesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(gesture)
    }

    // MARK: *** Actions ***

    @IBAction private func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view?.window)

        switch sender.state {

            case .began:
                initialTouchPoint = touchPoint
            case .changed:
                if touchPoint.y - initialTouchPoint.y > 0 {
                    self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }
            case .ended, .cancelled:
                if touchPoint.y - initialTouchPoint.y > Configurations.dragThreshold {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    })
                }

            default: break;
        }
    }

    @IBAction private func dismissViewController(_ sender: UIBarButtonItem) {

        if let v = navigationController, v.viewControllers.first != self {
            v.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

