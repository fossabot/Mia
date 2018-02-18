// TODO: - Mia
// TODO: [MIA] Fonts/Icons (see Material)


// TODO: - Logging
// TODO: [Rosewood] Implement a crash reporter
// TODO: [Rosewood] Implement a way to measure/monitor FPS | Watchdog

import UIKit

let internalKey = "io.multinerd"

public class MiaDummy: NSObject { }
public struct Mia {
    public static let bundle: Bundle = Bundle(for: MiaDummy.self)
}



func openSettings()  {
    DispatchQueue.main.async {
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
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



public typealias NetworkActivityBlock = () -> Void

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
                
                
                if (Bundle.main.bundleIdentifier!.contains("CactusQueue")) {
                    GradientLoadingBar.orange.show()
                } else {
                    GradientLoadingBar.shared.show()
                }
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
                
                if (Bundle.main.bundleIdentifier!.contains("CactusQueue")) {
                    GradientLoadingBar.orange.hide()
                } else {
                    GradientLoadingBar.shared.hide()
                }
                
                completion?()
            }
        })
    }
}


public func localThreadSingleton<T: AnyObject>(key: String, create: () -> T) -> T {
    if let cachedObj = Thread.current.threadDictionary[key] as? T {
        return cachedObj
    } else {
        let newObject = create()
        Thread.current.threadDictionary[key] = newObject
        return newObject
    }
}


// MARK: - *** Delegate ***
// MARK: - *** Shared ***
// MARK: - *** Configurations ***
// MARK: - *** Init / Deinit ***
// MARK: - *** Variables ***
// MARK: - *** Public Methods ***
// MARK: - *** Private / Helper Methods ***


