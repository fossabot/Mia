extension Encodable {

    /// Encode the model to a Data object.
    ///
    /// - Returns: The data object.
    public func toData() -> Data {

        do {
            return try CodableKit.encoder.encode(self)
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return Data()
        }
    }

    /// Encodes the model to a JSON string.
    ///
    /// - Returns: The JSON string.
    public func toString() -> String {

        return String(data: toData(), encoding: .utf8) ?? ""
    }

    /// Encode the model to a Dictionary.
    ///
    /// - Returns: The Dictionary.
    public func toDictionary() -> JSONDictionary {

        do {
            return try JSONSerialization.jsonObject(with: toData(), options: .mutableContainers) as! JSONDictionary
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return [:]
        }
    }

    /// Encode the model to an Array.
    ///
    /// - Returns: The Array.
    public func toArray() -> JSONArray {

        do {
            return try JSONSerialization.jsonObject(with: toData(), options: .mutableContainers) as! JSONArray
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return [ [:] ]
        }
    }
}
