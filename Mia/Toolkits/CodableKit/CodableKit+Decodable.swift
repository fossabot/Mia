extension Decodable {

    /// Decodes a new model from a decoded JSON string.
    ///
    /// - Parameters:
    ///   - json: The json string.
    ///   - keyPath: Optional root path.
    /// - Returns: The model or nil.
    public static func decode(json: String, keyPath: String? = nil) -> Self? {

        guard let data = json.data(using: .utf8) else { return nil }
        return decode(data: data, keyPath: keyPath)
    }

    /// Decodes a new model from a decoded Data object.
    ///
    /// - Parameters:
    ///   - data: The json data
    ///   - keyPath: Optional root path.
    /// - Returns: The model or nil.
    public static func decode(data: Data, keyPath: String? = nil) -> Self? {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = CodableKit.Configurations.Decoding.dateStrategy
        decoder.dataDecodingStrategy = CodableKit.Configurations.Decoding.dataStrategy

        do {
            if let keyPath = keyPath, !keyPath.isEmpty {
                let topLevel = try JSONSerialization.jsonObject(with: data, options: [ .allowFragments ])
                guard let nestedJson = (topLevel as AnyObject).value(forKeyPath: keyPath) else { return nil }
                let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                return try decoder.decode(self, from: nestedData)
            }
            return try decoder.decode(self, from: data)
        } catch let error as NSError {
            CodableKit.log(message: "\(error.userInfo)")
            return nil
        }
    }
}

extension JSONDecoder.DateDecodingStrategy {

    public static var datetimeDotNet: JSONDecoder.DateDecodingStrategy {
        let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .custom {
            let container = try $0.singleValueContainer()
            let dateStr = try container.decode(String.self)
            return Date(dateTimeString: dateStr)!
        }
        return dateDecodingStrategy
    }

    public static var yyyyMMdd: JSONDecoder.DateDecodingStrategy {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(dateFormatter)
        return dateDecodingStrategy
    }

    public static var short: JSONDecoder.DateDecodingStrategy {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(dateFormatter)
        return dateDecodingStrategy
    }
}
