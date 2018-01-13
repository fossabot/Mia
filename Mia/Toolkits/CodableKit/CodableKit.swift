public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [[String: Any]]

public class CodableKit {

    public static var isLoggingEnabled = true

    public static var encoder: JSONEncoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        return encoder
    }

    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom {
            let container = try $0.singleValueContainer()
            let dateStr = try container.decode(String.self)
            return Date(dateTimeString: dateStr)!
        }

        return decoder
    }

    static func log(message: String) {

        if isLoggingEnabled {
            Rosewood.Framework.print(framework: String(describing: self), message: message)
        }
    }
}

