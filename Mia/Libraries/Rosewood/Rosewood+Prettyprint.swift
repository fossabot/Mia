// MARK: -
extension Rosewood {
    public struct PrettyPrint {
    }
}

// MARK: -
extension Rosewood.PrettyPrint {

    // MARK: Public Methods

    /// Prettyprint an item.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func items(_ items: Any?..., file: String = #file, line: Int = #line, function: String = #function) {

        for item in items {
            log(.pretty, item, file, line, function)
        }
    }

    // MARK: Private Methods

    private static func log(_ level: LogLevel, _ item: Any?, _ file: String, _ line: Int, _ function: String) {

        guard Rosewood.Configuration.enabled else { return }

        var type = "nil"
        var jsonString: String? = nil

        if let value = item {
            type = String(describing: Mirror(reflecting: value).subjectType)

            switch value {
                case _ as Int: break
                case _ as Double: break
                case _ as Float: break
                case _ as String: break
                case _ as Bool: break
                case let array as NSArray: jsonString = prettyPrint(NSObject.reflect(objects: array))
                case let dict as NSDictionary: jsonString = prettyPrint(dict) ?? "\n\(dict)"
                case let error as NSError:
                    //@formatter:off
                    let properties: [String: Any] = [ "domain": error.domain,
                                                      "code": error.code,
                                                      "localizedDescription": error.localizedDescription,
                                                      "userInfo": error.userInfo ]
                    //@formatter:on
                    jsonString = prettyPrint(properties)
                    break

                case let object as NSObject:
                    let dictionary = NSObject.reflect(object: object)
                    if !dictionary.isEmpty { jsonString = prettyPrint(dictionary) }
                    break
                default:
                    break
            }
        }

        let message = "[\(type)] \(jsonString ?? addDash(item ?? "nil"))"
        let result = Rosewood.Configuration.formatter.prettyFormat(.pretty, item: message, file: file, line: line, function: function)
        Rosewood.printToDebugger(result)
    }

    private static func prettyPrint(_ object: Any) -> String? {

        do {
            if JSONSerialization.isValidJSONObject(object) {
                let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                    return "\n" + string
                }
            }
            throw NSError(domain: "unable to parse json object", code: 400, userInfo: nil)
        } catch {
            return nil
        }
    }

    private static func addDash(_ x: Any) -> String {

        let string = "\(x)"
        return "- " + (string.isEmpty ? "\"\"" : string)
    }
}

// MARK: - Helpers
private extension NSObject {

    class func reflect(objects: NSArray?) -> [Any] {

        guard let objects = objects else { return [] }

        return objects.map { value -> Any in
            if let value = value as? String {
                return value
            } else if let value = value as? [String] {
                return value
            } else if value is Bool {
                return value
            } else if let value = value as? Int {
                return value
            } else if let value = value as? [Int] {
                return value
            } else if let value = value as? Float {
                return value
            } else if let value = value as? [Float] {
                return value
            } else if let value = value as? Double {
                return value
            } else if let value = value as? [Double] {
                return value
            } else if let value = value as? NSDictionary {
                return value
            } else if let value = value as? NSArray {
                return NSObject.reflect(objects: value)
            } else {
                return NSObject.reflect(object: value)
            }
        }
    }

    class func reflect(object: Any?) -> [String: Any] {

        guard let object = object else { return [:] }

        var dictionary: [String: Any] = [:]
        Mirror(reflecting: object).children.forEach { label, value in
            if let key = label, let value = value as? String {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [String] {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? Int {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [Int] {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? Float {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [Float] {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? Double {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [Double] {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? Bool {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [Bool] {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? NSDictionary {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? NSArray {
                let objects = NSObject.reflect(objects: value)
                if objects.isEmpty {
                    dictionary.updateValue("null", forKey: key)
                } else {
                    dictionary.updateValue(objects, forKey: key)
                }
            } else if let key = label, let value = value as? NSObject {
                let object = NSObject.reflect(object: value)
                if object.isEmpty {
                    dictionary.updateValue(value, forKey: key)
                } else {
                    dictionary.updateValue(object, forKey: key)
                }
            } else if let key = label {
                let object = NSObject.reflect(object: value)
                if object.isEmpty {
                    dictionary.updateValue("null", forKey: key)
                } else {
                    dictionary.updateValue(object, forKey: key)
                }
            }
        }

        return dictionary
    }
}
