import UIKit

class ViewControllerInitializerDemoViews: UIViewController {

    @IBAction func pressRed(_ sender: Any) {

        let vc = RedViewController.instantiateFromStoryboard(name: "ViewControllerInitializerDemo")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func pressGreen(_ sender: Any) {

        let vc = GreenViewController.instantiateFromStoryboard(name: "ViewControllerInitializerDemo")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func pressBlue(_ sender: Any) {

        let vc = BlueViewController.instantiateFromStoryboard(name: "ViewControllerInitializerDemo")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func pressOrange(_ sender: Any) {

        let vc = OrangeViewController.instantiateFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class RedViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class GreenViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

class BlueViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class OrangeViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

