import UIKit

public protocol FontType {}

public struct Font {
    
    /// Size of font.
    public static let pointSize: CGFloat = 16

    public static func systemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public static func boldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    public static func italicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
    
    /**
     Loads a given font if needed.
     - Parameter name: A String font name.
     */
    public static func loadFontIfNeeded(name: String) {
        FontLoader.loadFontIfNeeded(name: name)
    }
}

/// Loads fonts packaged with Material.
private struct FontLoader {
    /// A Dictionary of the fonts already loaded.
    static var loadedFonts: Dictionary<String, String> = Dictionary<String, String>()
    
    /**
     Loads a given font if needed.
     - Parameter fontName: A String font name.
     */
    static func loadFontIfNeeded(name: String) {
        let loadedFont: String? = FontLoader.loadedFonts[name]
        
        if loadedFont == nil && UIFont(name: name, size: 1) == nil {
            FontLoader.loadedFonts[name] = name
            
            let bundle = Bundle(for: MiaDummy.self)
            let identifier = bundle.bundleIdentifier
            let fontURL = true == identifier?.hasPrefix("org.cocoapods")
                ? bundle.url(forResource: name, withExtension: "ttf", subdirectory: "io.multinerd.mia.fonts.bundle")
                : bundle.url(forResource: name, withExtension: "ttf")
            
            if let v = fontURL {
                let data = NSData(contentsOf: v as URL)!
                let provider = CGDataProvider(data: data)!
                let font = CGFont(provider)!
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    let errorDescription = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError = error!.takeUnretainedValue() as Any as! Error
                    NSException(name: .internalInconsistencyException, reason: errorDescription as String?, userInfo: [NSUnderlyingErrorKey: nsError as Any]).raise()
                }
            }
        }
    }
}




