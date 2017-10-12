public struct Icon {

    /// An internal reference to the icons bundle.
    private static var internalBundle: Bundle?
    
    public static var bundle: Bundle {
        if Icon.internalBundle == nil {
            Icon.internalBundle = Mia.bundle
            let url = Icon.internalBundle!.resourceURL!
            let b = Bundle(url: url.appendingPathComponent("io.multinerd.mia.icons.bundle"))
            if let v = b {
                Icon.internalBundle = v
            }
        }
        return Icon.internalBundle!
    }
    
    /// Get the icon by the file name.
    public static func icon(_ name: String) -> UIImage? {
        return UIImage(named: name, in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }
    
    
    
    
    public struct WebView {
        public static let back = Icon.icon("webview_back")
        public static let foward = Icon.icon("webview_foward")
        public static let dismiss = Icon.icon("webview_dismiss")
    }
    
    
    
    
}

