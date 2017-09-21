import UserNotifications

public final class PermissionKitNotifications: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    private func registerForRemoteNotifications() {

        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

extension PermissionKitNotifications: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitNotifications"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                    case .notDetermined: return completion(.notDetermined)
                    case .denied: return completion(.denied)
                    case .authorized: return completion(.authorized)
                }
            }
        } else if #available(iOS 9.0, *) {
            if let types = UIApplication.shared.currentUserNotificationSettings?.types {
                if types.isEmpty {
                    return completion(.notDetermined)
                }
            }

            return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [ .alert, .badge, .sound ]) { (granted, error) in

                if let error = error {
                    print("[PermissionKit.Notifications] Push notifications permission not determined 🤔, error: \(error)")
                    return completion(.notDetermined)
                }

                if granted {
                    self.registerForRemoteNotifications()
                    print("[PermissionKit.Notifications] Push notifications permission authorized by user ✅")
                    return completion(.authorized)
                }

                print("[PermissionKit.Notifications] Push notifications permission denied by user ⛔️")
                return completion(.denied)
            }
        } else if #available(iOS 9.0, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [ .badge, .sound, .alert ], categories: nil))
            self.registerForRemoteNotifications()
        }
    }

}
