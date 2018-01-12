import UIKit

public class WebViewModal: UINavigationController {

    public enum Theme {
        case light
        case dark
        case color(UIColor)
    }

    weak var webViewDelegate: UIWebViewDelegate? = nil

    public convenience init(urlString: String) {

        var urlString = urlString
        if !urlString.hasPrefix("https://") && !urlString.hasPrefix("http://") {
            urlString = "https://" + urlString
        }
        self.init(pageURL: URL(string: urlString)!)
    }

    public convenience init(urlString: String, theme: Theme) {

        self.init(pageURL: URL(string: urlString)!, theme: theme)
    }

    public convenience init(pageURL: URL) {

        self.init(request: URLRequest(url: pageURL))
    }

    public convenience init(pageURL: URL, theme: Theme) {

        self.init(request: URLRequest(url: pageURL), theme: theme)
    }

    public init(request: URLRequest, theme: Theme = .light) {
        
        let webViewController = WebView(aRequest: request)
        webViewController.storedStatusColor = UINavigationBar.appearance().barStyle

        let doneButton = UIBarButtonItem(image: Icon.WebView.dismiss, style: UIBarButtonItemStyle.plain, target: webViewController, action: #selector(WebView.doneButtonTapped))

        switch theme {
            case .light:
                doneButton.tintColor = .darkGray
                webViewController.buttonColor = .darkGray
                webViewController.titleColor = .black
                UINavigationBar.appearance().barStyle = .default
            
            case .dark:
                doneButton.tintColor = .white
                webViewController.buttonColor = .white
                webViewController.titleColor = .groupTableViewBackground
                UINavigationBar.appearance().barStyle = .black
            
            case .color(let color):
                doneButton.tintColor = color
                webViewController.buttonColor = color
                webViewController.titleColor = color
            
        }

        if (UIDevice.current.userInterfaceIdiom == .pad) {
            webViewController.navigationItem.leftBarButtonItem = doneButton
        } else {
            webViewController.navigationItem.rightBarButtonItem = doneButton
        }
        
        super.init(rootViewController: webViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override public func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(false)
    }
    
}
