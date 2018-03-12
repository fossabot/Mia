extension Encodable {

    /// Encode the model to a Data object.
    ///
    /// - Returns: The Data object.
    public func toJsonData() -> Data? {

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = CodableKit.Configurations.Encoding.outputFormatting
            encoder.dateEncodingStrategy = CodableKit.Configurations.Encoding.dateStrategy
            encoder.dataEncodingStrategy = CodableKit.Configurations.Encoding.dataStrategy
            
            return try encoder.encode(self)
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return nil
        }
    }

    /// Encodes the model to a JSON string.
    ///
    /// - Returns: The JSON String.
    public func toJsonString() -> String? {

        let data = self.toJsonData()
        return data == nil ? nil : String(data: data!, encoding: .utf8)
    }

    /// Encode the model to a Dictionary.
    ///
    /// - Returns: The Dictionary.
    public func toDictionary() -> JSONDictionary? {

        do {
            let data = self.toJsonData()
            return try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return nil
        }
    }

    /// Encode the model to an Array.
    ///
    /// - Returns: The Array.
    public func toArray() -> JSONArray? {

        do {
            let data = self.toJsonData()
            return try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONArray
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return nil
        }
    }
}

extension JSONEncoder.DateEncodingStrategy {

    public static var yyyyMMdd: JSONEncoder.DateEncodingStrategy {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .formatted(dateFormatter)
        return dateEncodingStrategy
    }

    public static var short: JSONEncoder.DateEncodingStrategy {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .formatted(dateFormatter)
        return dateEncodingStrategy
    }
}
