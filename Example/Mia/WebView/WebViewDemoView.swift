
import UIKit
import Mia

class WebViewDemoView: UIViewController {

    let generator = UIImpactFeedbackGenerator(style: .heavy)
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var modalLightButton: UIButton!
    @IBOutlet weak var modalDarkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        generator.prepare()
        
        let font = FontKit.Font.robotoLight.of(size: 14)
        pushButton.titleLabel?.font = font
        modalLightButton.titleLabel?.font = font
        modalDarkButton.titleLabel?.font = font
    }
    
    
    
    // MARK: Push
    @IBAction func push() {
        generator.impactOccurred()
        let webVC = WebView(urlString: "https://www.google.com")
        webVC.delegate = self
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    // MARK: Modal
    @IBAction func presentModalWithLightBlackTheme() {
        generator.impactOccurred()
        let webVC = WebViewModal(urlString: "https://www.google.com", theme: .light)
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func presentModalWithDarkTheme() {
        generator.impactOccurred()
        let webVC = WebViewModal(urlString: "https://www.google.com", theme: .dark)
        self.present(webVC, animated: true, completion: nil)
    }

}

extension WebViewDemoView: WebViewDelegate {
    
    func didStartLoading() {
        print("Started loading.")
    }
    
    func didFinishLoading(success: Bool) {
        print("Finished loading. Success: \(success).")
    }
    
}
