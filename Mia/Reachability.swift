import SystemConfiguration
import Foundation
import CoreTelephony


public enum ReachabilityError: Error {
    case FailedToCreateWithAddress(sockaddr_in)
    case FailedToCreateWithHostname(String)
    case UnableToSetCallback
    case UnableToSetDispatchQueue
}


public let ReachabilityChangedNotification = NSNotification.Name("ReachabilityChangedNotification")


func callback(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
    
    guard let info = info else { return }
    
    let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
    
    DispatchQueue.main.async {
        reachability.reachabilityChanged()
    }
}


public class Reachability {
    
    public typealias NetworkReachable = (Reachability) -> ()
    public typealias NetworkUnreachable = (Reachability) -> ()
    
    
    public enum NetworkStatus: CustomStringConvertible {
        
        case reachableViaWiFi, reachableVia2G, reachableVia3G, reachableVia4G, notReachable
        
        public var description: String {
            switch self {
                case .reachableVia2G: return "2G"
                case .reachableVia3G: return "3G"
                case .reachableVia4G: return "4G"
                case .reachableViaWiFi: return "WiFi"
                case .notReachable: return "No Connection"
            }
        }
        
    }
    
    
    public var whenReachable: NetworkReachable?
    
    public var whenUnreachable: NetworkUnreachable?
    
    public var reachableOnWWAN: Bool
    
    // The notification center on which "reachability changed" events are being posted
    
    public var notificationCenter: NotificationCenter = NotificationCenter.default
    
    public var currentReachabilityString: String {
        return "\(currentReachabilityStatus)"
    }
    
    public var currentReachabilityStatus: NetworkStatus {
        guard isReachable else {
            return .notReachable
        }
        
        if isReachableViaWiFi {
            return .reachableViaWiFi
        }
        
        if isRunningOnDevice {
            
            let teleInfo = CTTelephonyNetworkInfo()
            
            let access = teleInfo.currentRadioAccessTechnology ?? "Cellular"
            
            let typeStrings2G = [ CTRadioAccessTechnologyEdge,
                                  CTRadioAccessTechnologyGPRS,
                                  CTRadioAccessTechnologyCDMA1x ]
            
            let typeStrings3G = [ CTRadioAccessTechnologyHSDPA,
                                  CTRadioAccessTechnologyWCDMA,
                                  CTRadioAccessTechnologyHSUPA,
                                  CTRadioAccessTechnologyCDMAEVDORev0,
                                  CTRadioAccessTechnologyCDMAEVDORevA,
                                  CTRadioAccessTechnologyCDMAEVDORevB,
                                  CTRadioAccessTechnologyeHRPD ]
            
            let typeStrings4G = [ CTRadioAccessTechnologyLTE ]
            
            if typeStrings2G.contains(access) {
                return .reachableVia2G
            } else if typeStrings3G.contains(access) {
                return .reachableVia3G
            } else if typeStrings4G.contains(access) {
                return .reachableVia4G
            }
        }
        
        return .notReachable
    }
    
    fileprivate var previousFlags: SCNetworkReachabilityFlags?
    
    fileprivate var isRunningOnDevice: Bool = {
#if (arch(i386) || arch(x86_64)) && os(iOS)
        return false
#else
        return true
#endif
    }()
    
    fileprivate var notifierRunning = false
    
    fileprivate var reachabilityRef: SCNetworkReachability?
    
    fileprivate let reachabilitySerialQueue = DispatchQueue(label: "uk.co.ashleymills.reachability")
    
    required public init(reachabilityRef: SCNetworkReachability) {
        
        reachableOnWWAN = true
        self.reachabilityRef = reachabilityRef
    }
    
    
    public convenience init?(hostname: String) {
        
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostname) else { return nil }
        
        self.init(reachabilityRef: ref)
    }
    
    
    public convenience init?() {
        
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        
        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else { return nil }
        
        
        self.init(reachabilityRef: ref)
    }
    
    
    deinit {
        
        stopNotifier()
        
        reachabilityRef = nil
        whenReachable = nil
        whenUnreachable = nil
    }
}


public extension Reachability {
    
    // MARK: - *** Notifier methods ***
    func startNotifier() throws {
        
        guard let reachabilityRef = reachabilityRef, !notifierRunning else { return }
        
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &context) {
            stopNotifier()
            throw ReachabilityError.UnableToSetCallback
        }
        
        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifier()
            throw ReachabilityError.UnableToSetDispatchQueue
        }
        
        // Perform an initial check
        reachabilitySerialQueue.async {
            self.reachabilityChanged()
        }
        
        notifierRunning = true
    }
    
    
    func stopNotifier() {
        
        defer { notifierRunning = false }
        guard let reachabilityRef = reachabilityRef else { return }
        
        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }
    
    // MARK: - *** Connection test methods ***
    
    var isReachable: Bool {
        
        guard isReachableFlagSet else { return false }
        
        if isConnectionRequiredAndTransientFlagSet {
            return false
        }
        
        if isRunningOnDevice {
            if isOnWWANFlagSet && !reachableOnWWAN {
                // We don't want to connect when on 3G.
                return false
            }
        }
        
        return true
    }
    
    var isReachableViaWWAN: Bool {
        // Check we're not on the simulator, we're REACHABLE and check we're on WWAN
        return isRunningOnDevice && isReachableFlagSet && isOnWWANFlagSet
    }
    
    var isReachableViaWiFi: Bool {
        
        // Check we're reachable
        guard isReachableFlagSet else { return false }
        
        // If reachable we're reachable, but not on an iOS device (i.e. simulator), we must be on WiFi
        guard isRunningOnDevice else { return true }
        
        // Check we're NOT on WWAN
        return !isOnWWANFlagSet
    }
    
    var description: String {
        
        let W = isRunningOnDevice ? (isOnWWANFlagSet ? "W" : "-") : "X"
        let R = isReachableFlagSet ? "R" : "-"
        let c = isConnectionRequiredFlagSet ? "c" : "-"
        let t = isTransientConnectionFlagSet ? "t" : "-"
        let i = isInterventionRequiredFlagSet ? "i" : "-"
        let C = isConnectionOnTrafficFlagSet ? "C" : "-"
        let D = isConnectionOnDemandFlagSet ? "D" : "-"
        let l = isLocalAddressFlagSet ? "l" : "-"
        let d = isDirectFlagSet ? "d" : "-"
        
        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
    
}


fileprivate extension Reachability {
    
    func reachabilityChanged() {
        
        let flags = reachabilityFlags
        
        guard previousFlags != flags else { return }
        
        let block = isReachable ? whenReachable : whenUnreachable
        block?(self)
        
        self.notificationCenter.post(name: ReachabilityChangedNotification, object: self)
        
        previousFlags = flags
    }
    
    var isOnWWANFlagSet: Bool {
        return reachabilityFlags.contains(.isWWAN)
    }
    
    var isReachableFlagSet: Bool {
        return reachabilityFlags.contains(.reachable)
    }
    
    var isConnectionRequiredFlagSet: Bool {
        return reachabilityFlags.contains(.connectionRequired)
    }
    
    var isInterventionRequiredFlagSet: Bool {
        return reachabilityFlags.contains(.interventionRequired)
    }
    
    var isConnectionOnTrafficFlagSet: Bool {
        return reachabilityFlags.contains(.connectionOnTraffic)
    }
    
    var isConnectionOnDemandFlagSet: Bool {
        return reachabilityFlags.contains(.connectionOnDemand)
    }
    
    var isConnectionOnTrafficOrDemandFlagSet: Bool {
        return !reachabilityFlags.intersection([ .connectionOnTraffic, .connectionOnDemand ]).isEmpty
    }
    
    var isTransientConnectionFlagSet: Bool {
        return reachabilityFlags.contains(.transientConnection)
    }
    
    var isLocalAddressFlagSet: Bool {
        return reachabilityFlags.contains(.isLocalAddress)
    }
    
    var isDirectFlagSet: Bool {
        return reachabilityFlags.contains(.isDirect)
    }
    
    var isConnectionRequiredAndTransientFlagSet: Bool {
        return reachabilityFlags.intersection([ .connectionRequired, .transientConnection ]) == [ .connectionRequired, .transientConnection ]
    }
    
    var reachabilityFlags: SCNetworkReachabilityFlags {
        
        guard let reachabilityRef = reachabilityRef else { return SCNetworkReachabilityFlags() }
        
        var flags = SCNetworkReachabilityFlags()
        
        if SCNetworkReachabilityGetFlags(reachabilityRef, &flags) {
            return flags
        } else {
            return SCNetworkReachabilityFlags()
        }
    }
    
}
