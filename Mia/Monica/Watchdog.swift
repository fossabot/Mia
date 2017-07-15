import Foundation


/// Class for logging excessive blocking on the main thread.
public final class Watchdog {
    
    fileprivate let pingThread: PingThread
    
    /// Convenience initializer that allows you to construct a `WatchDog` object with default behavior.
    ///
    /// - Parameters:
    ///   - threshold: Number of seconds that must pass to consider the main thread blocked.
    ///   - strictMode: Boolean value that stops the execution whenever the threshold is reached.
    public convenience init(threshold: Double = 0.5, strictMode: Bool = false) {
        
        let result = "👮 Main thread was blocked for \(threshold.seconds) 👮\n)"
        
        self.init(threshold: threshold) {
//            Thread.callStackSymbols.forEach{print($0)}
            if strictMode {
                assertionFailure(result)
            } else {
                Swift.print(result)
            }
        }
        
    }
    
    private init(threshold: Double = 0.5, watchdogFiredCallback: @escaping () -> Void) {
        
        self.pingThread = PingThread(threshold: threshold, handler: watchdogFiredCallback)
        self.pingThread.start()
        
    }
    
    deinit {
        
        pingThread.cancel()
    }
    
}

private final class PingThread: Thread {
    
    fileprivate var pingTaskIsRunning = false
    
    fileprivate var semaphore = DispatchSemaphore(value: 0)
    
    fileprivate let threshold: Double
    
    fileprivate let handler: () -> Void
    
    init(threshold: Double, handler: @escaping () -> Void) {
        
        self.threshold = threshold
        self.handler = handler
    }
    
    override func main() {
        
        while !isCancelled {
            pingTaskIsRunning = true
            DispatchQueue.main.async {
                self.pingTaskIsRunning = false
                self.semaphore.signal()
            }
            
            Thread.sleep(forTimeInterval: threshold)
            if pingTaskIsRunning {
                handler()
            }
            
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        }
    }
    
}

// MARK: - Private Extensions

extension Double {
    
    var seconds: String {
        return String(format: "%03.2fs", self)
    }
    
}
