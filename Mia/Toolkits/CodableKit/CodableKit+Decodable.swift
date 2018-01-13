extension Decodable {

    public static func decode(from data: Data) -> Self? {

        do {
            return try CodableKit.decoder.decode(self, from: data)
        } catch let error {
            CodableKit.log(message: error.localizedDescription)
            return nil
        }
    }

    public static func decode(from string: String, keyPath: String? = nil) -> Self? {

        guard let data = string.data(using: .utf8) else {
            CodableKit.log(message: "Data is nil")
            return nil
        }

        if let keyPath = keyPath, !keyPath.isEmpty {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let object = (json as AnyObject).value(forKeyPath: keyPath)
                do {
                    let objKeypath = try JSONSerialization.data(withJSONObject: object ?? "", options: .prettyPrinted)
                    return decode(from: objKeypath)
                } catch let error {
                    CodableKit.log(message: error.localizedDescription)
                }
            } catch let error {
                CodableKit.log(message: error.localizedDescription)
            }
        } else {
            return decode(from: data)
        }
        return nil
    }
}
