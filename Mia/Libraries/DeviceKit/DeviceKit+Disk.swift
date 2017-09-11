import UIKit

public extension DeviceKit.Disk {

    /// The total disk space in bytes
    public static var totalSpace: Int64 {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
            return space!
        } catch {
            return 0
        }
    }

    /// The free disk space in bytes
    public static var freeSpace: Int64 {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
            return freeSpace!
        } catch {
            return 0
        }
    }

    /// The used disk space in bytes
    public static var usedSpace: Int64 {
        let usedSpace = totalSpace - freeSpace
        return usedSpace
    }

    /// The free disk space in percentage
    public static var freeSpacePercentage: Float {

        return (Float(freeSpace) * 100) / Float(totalSpace)
    }

    /// The used disk space in percentage
    public static var usedSpacePercentage: Float {

        return (Float(usedSpace) * 100) / Float(totalSpace)
    }

}
