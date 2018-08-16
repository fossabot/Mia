public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [[String: Any]]

public class CodableKit {

    public struct Configurations {

        public static var isLoggingEnabled = true

        public struct Encoding {
            public static var outputFormatting: JSONEncoder.OutputFormatting = []
            @available(iOS 10.0, *)
            public static var dateStrategy: JSONEncoder.DateEncodingStrategy = .iso8601
            public static var dataStrategy: JSONEncoder.DataEncodingStrategy = .base64
        }

        public struct Decoding {
            @available(iOS 10.0, *)
            public static var dateStrategy: JSONDecoder.DateDecodingStrategy = .iso8601
            public static var dataStrategy: JSONDecoder.DataDecodingStrategy = .base64
        }
    }

    static func log(message: String) {

        if Configurations.isLoggingEnabled {
            Rosewood.Framework.print(framework: String(describing: self), message: message)
        }
    }
}
