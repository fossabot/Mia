import Foundation


fileprivate var key = "theme_handler"


/// A marker protocol for theme
public protocol Theme {
}


/// Anything that wants to use theme
public protocol ThemeUser: class {
}


public extension ThemeUser {

    /// This is called immediately and when current theme changes.
    ///
    /// Usage
    /// ```
    /// textField.use(MyTheme.self) {
    ///   $0.textColor = $1.mainColor
    ///   $0.font = $1.textFont
    /// }
    ///
    /// - Parameters:
    ///   - type: The type of your own theme.
    ///   - apply: The function that gets called. (ThemeUser, Theme)
    func use<T:Theme>(_ type: T.Type, apply: @escaping (Self, T) -> Void) {
        
        if let theme = ThemeManager.shared.currentTheme as? T {
            apply(self, theme)
        }
        
        theme_handler.mapping[String(describing: type.self)] = { (themeUser: ThemeUser, theme: Theme) in
            guard let themeUser = themeUser as? Self,
                let theme = theme as? T else {
                    return
            }
            
            apply(themeUser, theme)
        }
    }

    
    
    func useAnimated<T:Theme>(_ type: T.Type, apply: @escaping (Self, T) -> Void) {
        
        if let theme = ThemeManager.shared.currentTheme as? T {
            UIView.animate(withDuration: 0.4, animations: { 
                apply(self, theme)
            })
        }
        
        theme_handler.mapping[String(describing: type.self)] = { (themeUser: ThemeUser, theme: Theme) in
            guard let themeUser = themeUser as? Self,
                let theme = theme as? T else {
                    return
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                apply(themeUser, theme)
            })
        }
    }

    fileprivate var theme_handler: Handler {
        if let handler = objc_getAssociatedObject(self, &key) as? Handler {
            return handler
        } else {
            let handler = Handler(host: self)
            handler.observe()
            objc_setAssociatedObject(self, &key, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return handler
        }
    }
}


/// MARK: - NSObject

extension NSObject: ThemeUser {
}
