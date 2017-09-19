// MARK: -

public protocol ThemeUser: class { }

public extension ThemeUser {

    // MARK: Public Methods

    /// This is called immediately and when current theme changes.
    ///
    /// - Parameters:
    ///   - type: The type of your own theme.
    ///   - apply: The function that gets called. (ThemeUser, Theme)
    @available(*, message: "use `useAnimated` instead!")
    func use<T: Theme>(_ type: T.Type, apply: @escaping (Self, T) -> Void) {

        if let theme = ThemeKit.shared.currentTheme as? T {
            apply(self, theme)
        }

        themeHandler.mapping[String(describing: type.self)] = { (themeUser: ThemeUser, theme: Theme) in
            guard let themeUser = themeUser as? Self,
                  let theme = theme as? T else {
                return
            }

            apply(themeUser, theme)
        }
    }

    /// This is called immediately and when current theme changes.
    ///
    /// - Parameters:
    ///   - type: The type of your own theme.
    ///   - apply: The function that gets called with animation. (ThemeUser, Theme)
    func useAnimated<T: Theme>(_ type: T.Type, apply: @escaping (Self, T) -> Void) {

        if let theme = ThemeKit.shared.currentTheme as? T {
            UIView.animate(withDuration: 0.4, animations: {
                apply(self, theme)
            })
        }

        themeHandler.mapping[String(describing: type.self)] = { (themeUser: ThemeUser, theme: Theme) in
            guard let themeUser = themeUser as? Self,
                  let theme = theme as? T else {
                return
            }

            UIView.animate(withDuration: 0.4, animations: {
                apply(themeUser, theme)
            })
        }
    }

    // MARK: Private Methods

    private var themeHandler: Handler {

        var key = "theme_handler"
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

extension NSObject: ThemeUser { }

// MARK: -

private class Handler {

    weak var host: ThemeUser?

    var observer: NSObjectProtocol!

    var mapping = [ String: (ThemeUser, Theme) -> Void ]()

    init(host: ThemeUser) {

        self.host = host
    }

    deinit {

        NotificationCenter.default.removeObserver(observer)
    }

    func observe() {

        observer = NotificationCenter.default.addObserver(forName: Notification.Name.themeDidChange, object: ThemeKit.shared, queue: OperationQueue.main, using: { [weak self] _ in
            self?.handle()
        })
    }

    func handle() {

        guard let host = host else {
            return
        }

        guard let theme = ThemeKit.shared.currentTheme else {
            return
        }

        guard let action = mapping[String(describing: type(of: theme))] else {
            return
        }

        action(host, theme)
    }

}
