import UIKit
import Mia

// MARK: - *** ViewControllerInitializerDemoViews ***

class ViewControllerInitializerDemoViews: UIViewController {

    // MARK: *** Properties ***

    @IBOutlet weak var switchLabel: UILabel!

    @IBOutlet weak var switcher: UISwitch! {
        didSet {
            switcher.on.valueChanged {
                self.switchLabel.text = self.switcher.isOn ? "Push" : "Present"
            }
        }
    }

    // MARK: *** Actions ***

    @IBAction func createRedViewController(_ sender: Any) {

        let vc = RedViewController.instantiateFromStoryboard(name: "ViewControllerInitializerDemo")
        show(vc: vc)
    }

    @IBAction func createGreenViewController(_ sender: Any) {

        let vc = GreenViewController.instantiateFromNib()
        show(vc: vc)
    }

    @IBAction func createBlueViewController(_ sender: Any) {

        let vc = BlueViewController.instantiateFromStoryboard(name: "ViewControllerInitializerDemo")
        show(vc: vc)
    }

    // MARK: *** Helpers ***
    private func show(vc: UIViewController) {

        if switcher.isOn {
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let navi = vc.embedInNavigationController(dismissType: .button)
            self.present(navi, animated: true, completion: nil)
        }
    }
}

// MARK: - *** RedViewController ***

class RedViewController: UIViewController {
}

// MARK: - *** GreenViewController ***

class GreenViewController: UIViewController {
}

// MARK: - *** BlueViewController ***

class BlueViewController: UIViewController {
}
