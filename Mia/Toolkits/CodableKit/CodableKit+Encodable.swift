extension Encodable {

    public func toData() -> Data {

        do {
            return try CodableKit.encoder.encode(self)
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return Data()
        }
    }

    public func toString() -> String {

        return String(data: toData(), encoding: .utf8) ?? ""
    }

    public func toDictionary() -> JSONDictionary {

        do {
            return try JSONSerialization.jsonObject(with: toData(), options: .mutableContainers) as! JSONDictionary
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return [:]
        }
    }

    public func toArray() -> JSONArray {

        do {
            return try JSONSerialization.jsonObject(with: toData(), options: .mutableContainers) as! JSONArray
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return [ [:] ]
        }
    }
}
