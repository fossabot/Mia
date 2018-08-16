import WebKit

// MARK: -
public protocol WebViewDelegate: class {
    func didStartLoading()

    func didFinishLoading(success: Bool)
}

// MARK: -
public class WebView: UIViewController {

    public weak var delegate: WebViewDelegate?

    var storedStatusColor: UIBarStyle?
    var navBarTitle: UILabel!

    var buttonColor: UIColor? = nil
    var titleColor: UIColor? = nil

    var closing: Bool! = false
    var request: URLRequest!

    lazy var webView: WKWebView = {

        var tempWebView = WKWebView.init(frame: UIScreen.main.bounds)
        tempWebView.uiDelegate = self
        tempWebView.navigationDelegate = self
        return tempWebView;
    }()

    lazy var backBarButtonItem: UIBarButtonItem = {
        var tempBackBarButtonItem = UIBarButtonItem(image: Icon.WebView.back, style: .plain, target: self, action: #selector(WebView.goBackTapped(_:)))
        tempBackBarButtonItem.width = 18.0
        tempBackBarButtonItem.tintColor = self.buttonColor
        return tempBackBarButtonItem
    }()

    lazy var forwardBarButtonItem: UIBarButtonItem = {
        var tempForwardBarButtonItem = UIBarButtonItem(image: Icon.WebView.foward, style: .plain, target: self, action: #selector(WebView.goForwardTapped(_:)))
        tempForwardBarButtonItem.width = 18.0
        tempForwardBarButtonItem.tintColor = self.buttonColor
        return tempForwardBarButtonItem
    }()

    lazy var refreshBarButtonItem: UIBarButtonItem = {
        var tempRefreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(WebView.reloadTapped(_:)))
        tempRefreshBarButtonItem.tintColor = self.buttonColor
        return tempRefreshBarButtonItem
    }()

    lazy var stopBarButtonItem: UIBarButtonItem = {
        var tempStopBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(WebView.stopTapped(_:)))
        tempStopBarButtonItem.tintColor = self.buttonColor
        return tempStopBarButtonItem
    }()

    lazy var actionBarButtonItem: UIBarButtonItem = {
        var tempActionBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebView.actionButtonTapped(_:)))
        tempActionBarButtonItem.tintColor = self.buttonColor
        return tempActionBarButtonItem
    }()

    // MARK: Init/DeInit
    public convenience init(urlString: String) {

        var urlString = urlString
        if !urlString.hasPrefix("https://") && !urlString.hasPrefix("http://") {
            urlString = "https://" + urlString
        }
        self.init(pageURL: URL(string: urlString)!)
    }

    public convenience init(pageURL: URL) {

        self.init(aRequest: URLRequest(url: pageURL))
    }

    public convenience init(aRequest: URLRequest) {

        self.init()
        self.request = aRequest
    }

    deinit {
        
        webView.stopLoading()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        webView.uiDelegate = nil;
        webView.navigationDelegate = nil;
    }

    // MARK: *** View Life Cycle ***
    override public func viewDidLoad() {

        super.viewDidLoad()
    }

    override public func viewWillAppear(_ animated: Bool) {

        assert(self.navigationController != nil, "SVWebViewController needs to be contained in a UINavigationController. If you are presenting SVWebViewController modally, use SVModalWebViewController instead.")

        
        updateToolbarItems()
        navBarTitle = UILabel()
        navBarTitle.backgroundColor = .clear
        if let color = navigationController?.navigationBar.titleTextAttributes?[.foregroundColor] as? UIColor {
            navBarTitle.textColor = color
        } else {
            navBarTitle.textColor = self.titleColor
        }
        navBarTitle.shadowOffset = CGSize(width: 0, height: 1);
        navBarTitle.font = UIFont(name: "Roboto-Medium", size: 17.0)
        navBarTitle.textAlignment = .center
        navigationItem.titleView = navBarTitle;

        super.viewWillAppear(true)

        if (UIDevice.current.userInterfaceIdiom == .phone) {
            self.navigationController?.setToolbarHidden(false, animated: false)
        } else if (UIDevice.current.userInterfaceIdiom == .pad) {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }

    override public func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(true)

        if (UIDevice.current.userInterfaceIdiom == .phone) {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }

    override public func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    override public func loadView() {
        
        view = webView
        webView.load(request)
    }

    // MARK: *** Private Methods ***
    func updateToolbarItems() {

        backBarButtonItem.isEnabled = webView.canGoBack
        forwardBarButtonItem.isEnabled = webView.canGoForward

        let refreshStopBarButtonItem: UIBarButtonItem = webView.isLoading ? stopBarButtonItem : refreshBarButtonItem

        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        if (UIDevice.current.userInterfaceIdiom == .pad) {

            let toolbarWidth: CGFloat = 250.0
            fixedSpace.width = 35.0

            let items: NSArray = [ fixedSpace, refreshStopBarButtonItem, fixedSpace, backBarButtonItem, fixedSpace, forwardBarButtonItem, fixedSpace, actionBarButtonItem ]

            let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: toolbarWidth, height: 44.0))
            if !closing {
                toolbar.items = items as? [UIBarButtonItem]
                if presentingViewController == nil {
                    toolbar.barTintColor = navigationController!.navigationBar.barTintColor
                } else {
                    toolbar.barStyle = navigationController!.navigationBar.barStyle
                }
                toolbar.tintColor = navigationController!.navigationBar.tintColor
            }
            navigationItem.rightBarButtonItems = items.reverseObjectEnumerator().allObjects as? [UIBarButtonItem]

        } else {
            let items: NSArray = [ fixedSpace, backBarButtonItem, flexibleSpace, forwardBarButtonItem, flexibleSpace, refreshStopBarButtonItem, flexibleSpace, actionBarButtonItem, fixedSpace ]

            if let navigationController = navigationController, !closing {
                if presentingViewController == nil {
                    navigationController.toolbar.barTintColor = navigationController.navigationBar.barTintColor
                } else {
                    navigationController.toolbar.barStyle = navigationController.navigationBar.barStyle
                }
                navigationController.toolbar.tintColor = navigationController.navigationBar.tintColor
                toolbarItems = items as? [UIBarButtonItem]
            }
        }
    }

}

// MARK: -
extension WebView {

    @objc func goBackTapped(_ sender: UIBarButtonItem) {
        
        webView.goBack()
    }
    
    @objc func goForwardTapped(_ sender: UIBarButtonItem) {
        
        webView.goForward()
    }
    
    @objc func reloadTapped(_ sender: UIBarButtonItem) {
        
        webView.reload()
    }
    
    @objc func stopTapped(_ sender: UIBarButtonItem) {
        
        webView.stopLoading()
        updateToolbarItems()
    }

    @objc func actionButtonTapped(_ sender: AnyObject) {
        
        if let url: URL = ((webView.url != nil) ? webView.url : request.url) {
            
            if url.absoluteString.hasPrefix("file:///") {
                let dc: UIDocumentInteractionController = UIDocumentInteractionController(url: url)
                dc.presentOptionsMenu(from: view.bounds, in: view, animated: true)
            } else {
                let activityController: UIActivityViewController = UIActivityViewController(activityItems: [ url ], applicationActivities: [])
                
                if floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 && UIDevice.current.userInterfaceIdiom == .pad {
                    let ctrl: UIPopoverPresentationController = activityController.popoverPresentationController!
                    ctrl.sourceView = view
                    ctrl.barButtonItem = sender as? UIBarButtonItem
                }
                
                present(activityController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func doneButtonTapped() {
        
        closing = true
        UINavigationBar.appearance().barStyle = storedStatusColor!
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: -
extension WebView: WKUIDelegate {

    // Add any desired WKUIDelegate methods here: https://developer.apple.com/reference/webkit/wkuidelegate

}

// MARK: -
extension WebView: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        self.delegate?.didStartLoading()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        updateToolbarItems()
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        self.delegate?.didFinishLoading(success: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        webView.evaluateJavaScript("window.scrollTo(0, 0)", completionHandler: nil)
        webView.evaluateJavaScript("document.title", completionHandler: { (response, error) in
            self.navBarTitle.text = response as! String?
            self.navBarTitle.sizeToFit()
            self.updateToolbarItems()
        })
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

        self.delegate?.didFinishLoading(success: false)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        updateToolbarItems()
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        if (navigationAction.targetFrame == nil) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }

        // To connnect app store
        if url.host == "itunes.apple.com" {
            if UIApplication.shared.canOpenURL(navigationAction.request.url!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                decisionHandler(.cancel)
                return
            }
        }

        let url_elements = url.absoluteString.components(separatedBy: ":")
        switch url_elements[0] {
            case "tel":
                openCustomApp(urlScheme: "telprompt://", additional_info: url_elements[1])
                decisionHandler(.cancel)

            case "sms":
                openCustomApp(urlScheme: "sms://", additional_info: url_elements[1])
                decisionHandler(.cancel)

            case "mailto":
                openCustomApp(urlScheme: "mailto://", additional_info: url_elements[1])
                decisionHandler(.cancel)

            default:
                print("Default")
        }

        decisionHandler(.allow)

    }

}

// MARK: -
extension WebView {


    func openCustomApp(urlScheme: String, additional_info: String) {

        if let requestUrl: URL = URL(string: "\(urlScheme)\(additional_info)") {
            let application: UIApplication = UIApplication.shared
            if application.canOpenURL(requestUrl) {
                if #available(iOS 10.0, *) {
                    application.open(requestUrl, options: [:], completionHandler: nil)
                } else {
                    application.openURL(requestUrl)
                }
            }
        }
    }

}
