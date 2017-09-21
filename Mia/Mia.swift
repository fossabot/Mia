// TODO: - Logging
// TODO: [Rosewood] Implement a crash reporter

// TODO: - Performance
// TODO: [Monica] Implement a way to measure/monitor FPS | Watchdog

// TODO: - JSON
// TODO: [Reflect] Document all the things
// TODO: [Reflect] Replace With EVReflection

// TODO: - PDF
// TODO: [HTMLtoPDF] Extension methods to save data to file and return file path
import UIKit



func openSettings()  {
    DispatchQueue.main.async {
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.openURL(settingsURL)
        }
    }
}

public func getTopMostController() -> UIViewController? {

    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    return nil
}


public typealias NetworkActivityBlock = () -> ()

var __internalActivityCount: Int = 0
//{
//    didSet {
//        Rosewood.verbose("Network.Count: \(__internalActivityCount)")
//    }
//}


//public postfix func ++ (networkActivityObserver: NetworkActivityIndicatorObserver) {
//    networkActivityObserver.increment()
//}
//
//public postfix func -- (networkActivityObserver: NetworkActivityIndicatorObserver) {
//    networkActivityObserver.decrement()
//}

public func showNetworkActivity() {

    let shared = UIApplication.shared
    let lockQueue = DispatchQueue(label: "self")
    lockQueue.async {
        __internalActivityCount += 1
        DispatchQueue.main.async(execute: { () -> Void in
            if !shared.isNetworkActivityIndicatorVisible && __internalActivityCount > 0 {
                shared.isNetworkActivityIndicatorVisible = true
                GradientLoadingBar.shared.show()

            }
        })
    }
}


public func hideNetworkActivity(_ completion: NetworkActivityBlock? = nil) {

    let shared = UIApplication.shared
    let lockQueue = DispatchQueue(label: "self")
    lockQueue.async {
        if __internalActivityCount == 0 {
            return
        }
        __internalActivityCount -= 1
        DispatchQueue.main.async(execute: { () -> Void in
            if shared.isNetworkActivityIndicatorVisible && __internalActivityCount == 0 {
                shared.isNetworkActivityIndicatorVisible = false
                GradientLoadingBar.shared.hide()
                completion?()
            }
        })
    }
}


// MARK: - Delegate


// MARK: - Shared


// MARK: - Configurations


// MARK: - Init/Deinit


// MARK: - Variables


// MARK: - Public Methods


// MARK: - Private Methods


// MARK: - Helpers

