import UIKit
import MessageUI
import Mia.Swift


class ViewController: UIViewController {

    var html: HTMLtoPDF?

    override func viewDidLoad() {

        super.viewDidLoad()

        
        let colors = [UIColor.black, UIColor.orange, .purple]
        
        let asd = colors.gradient { gradient in
            gradient.frame = self.view.bounds
            gradient.speed = 1.0
            self.view.layer.insertSublayer(gradient, at: 0)
            return gradient
        }
        
        
        navigationController?.navigationBar.backgroundColor = colors.pickColorAt(scale: 0.95)
        


//        view.layer.insertSublayer(gradient2, at: 0)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    
}


/*

let kSplashIntro : String = "SplashIntro"
let kValueStepper : String = "ValueStepper"
let kUIColor : String = "UIColor"


// MARK: - MNTableViewDemoSwift
class MNTableViewDemoSwift: UITableViewController {
    
    fileprivate var dataSource: Array =  [kSplashIntro, kValueStepper, kUIColor]
    
    fileprivate var revealingLoaded = false
    
    override var shouldAutorotate: Bool {
        return revealingLoaded
    }
    
    override var prefersStatusBarHidden: Bool {
        return !revealingLoaded
    }
    
    override func viewDidLoad() {
        setupNavigationStacks()
    }
    
    
}



// MARK: - UITableViewDataSource
extension MNTableViewDemoSwift {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = dataSource[indexPath.row]
        return cell
    }
    
}



// MARK: - UITableViewDelegate
extension MNTableViewDemoSwift {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: showSplash()
        case 1: self.performSegue(withIdentifier: "gotoValueStepper", sender: nil)
        case 2: self.performSegue(withIdentifier: "gotoUIColor", sender: nil)
        default: return
        }
    }
    
}



// MARK: - SplashIntro
extension MNTableViewDemoSwift {
    
    func showSplash() {
        self.revealingLoaded = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        playAppLaunchSplashAnimation(iconImage: UIImage(named: "launchLogo")!, iconSize: CGSize(width: 200, height: 200), backgroundColor: UIColor.random()) {
            print("Done Launching App Splash")
            self.revealingLoaded = true
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    
}



// MARK: - NavigationStacks
extension MNTableViewDemoSwift: UIGestureRecognizerDelegate {
    
    func setupNavigationStacks() -> Void {
        navigationController!.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if navigationController?.viewControllers.count == 2 {
            return true
        }
        
        if let navigationController = self.navigationController as? NavigationStack {
            navigationController.showControllers()
        }
        
        return false
    }
    
}



// MARK: - MNTableViewCellDemoSwift
class MNTableViewDemoSwiftCell: UITableViewCell {
    @IBOutlet var frameworkName: UILabel!
    
}


 */
