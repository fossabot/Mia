import CoreMotion
import UIKit

public extension DeviceKit.Sensors {

    /// Determines whether gyro is available
    public static var isGyroAvailable: Bool {

        return CMMotionManager().isGyroAvailable
    }

    /// Determines whether the accelerometer is available
    public static var isAccelerometerAvailable: Bool {

        return CMMotionManager().isAccelerometerAvailable
    }

    /// Determines whether magnetometer is available
    public static var isMagnetometerAvailable: Bool {

        return CMMotionManager().isMagnetometerAvailable
    }

    /// Determines whether device motion is available
    public static var isDeviceMotionAvailable: Bool {

        return CMMotionManager().isDeviceMotionAvailable
    }

}
