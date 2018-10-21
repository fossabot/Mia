import UIKit


public enum MiaError: Error {

    case UpdateFailed
    case jsonEncodingFailed(error: Error)

}
