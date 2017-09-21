import Speech

public final class PermissionKitSpeechRecognizer: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitSpeechRecognizer: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitSpeechRecognizer"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        if #available(iOS 10.0, *) {
            let status = SFSpeechRecognizer.authorizationStatus()
            switch status {
                case .authorized: return completion(.authorized)
                case .restricted, .denied: return completion(.denied)
                case .notDetermined: return completion(.notDetermined)
            }
        }
        return completion(.notAvailable)
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        if #available(iOS 10.0, *) {
            SFSpeechRecognizer.requestAuthorization { status in
                switch status {
                    case .authorized:
                        print("[PermissionKit.SpeechRecognizer] 🗣 permission authorized by user ✅")
                        return completion(.authorized)

                    case .restricted, .denied:
                        print("[PermissionKit.SpeechRecognizer] 🗣 permission denied by user ⛔️")
                        return completion(.denied)

                    case .notDetermined:
                        print("[PermissionKit.SpeechRecognizer] 🗣 permission not determined 🤔")
                        return completion(.notDetermined)
                }
            }
        }

        print("[PermissionKit.SpeechRecognizer] 🗣 permission only available from iOS 10 ⛔️")
        return completion(.notAvailable)
    }

}
