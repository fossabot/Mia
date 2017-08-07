// TODO: - Logging
// TODO: [Rosewood] Implement a crash reporter

// TODO: - Performance
// TODO: [Monica] Implement a way to measure/monitor FPS | Watchdog

// TODO: - JSON
// TODO: [Reflect] Document all the things


// TODO: - PDF
// TODO: [HTMLtoPDF] Extension methods to save data to file and return file path


public func getTopMostController() -> UIViewController? {

    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    return nil
}
