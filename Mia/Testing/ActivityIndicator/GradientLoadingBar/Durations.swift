import Foundation


public struct Durations {
    let fadeIn: Double
    let fadeOut: Double
    let progress: Double

    public init(fadeIn: Double = 0.0, fadeOut: Double = 0.0, progress: Double = 0.0) {

        self.fadeIn = fadeIn
        self.fadeOut = fadeOut
        self.progress = progress
    }
}
