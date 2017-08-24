// MARK: - String
extension String {

    var lastPathComponent: String {
        return NSString(string: self).lastPathComponent
    }

    var stringByDeletingPathExtension: String {
        return NSString(string: self).deletingPathExtension
    }

}

// MARK: - Double
extension Double {

    var asMilliSeconds: String {
        return String(format: "%03.2fms", self * 1000)
    }

    var asSeconds: String {
        return String(format: "%03.2fs", self)
    }

}

// MARK: - NSObject
extension NSObject {

    public class func reflect(objects: NSArray) -> [Any] {

        return objects.map { value -> Any in
            // strings
            if let value = value as? String {
                return value
            } else if let value = value as? [String] {
                return value
            }

            // booleans
            else if value is Bool {
                return value
            }

            // numbers
            else if let value = value as? Int {
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
            }

            // dictionaries
            else if let value = value as? NSDictionary {
                return value
            }

            // arrays
            else if let value = value as? NSArray {
                return NSObject.reflect(objects: value)
            }

            // objects
            else {
                return NSObject.reflect(object: value)
            }
        }
    }

    public class func reflect(object: Any?) -> [String: Any] {

        guard let object = object else {
            return [:]
        }

        var dictionary: [String: Any] = [:]

        Mirror(reflecting: object).children.forEach { label, value in
            // strings
            if let key = label, let value = value as? String {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [String] {
                dictionary.updateValue(value, forKey: key)
            }

            // numbers
            else if let key = label, let value = value as? Int {
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
            }

            // booleans
            else if let key = label, let value = value as? Bool {
                dictionary.updateValue(value, forKey: key)
            } else if let key = label, let value = value as? [Bool] {
                dictionary.updateValue(value, forKey: key)
            }

            // dictionaries
            else if let key = label, let value = value as? NSDictionary {
                dictionary.updateValue(value, forKey: key)
            }

            // objects
            else if let key = label, let value = value as? NSArray {
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
