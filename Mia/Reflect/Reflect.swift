import Foundation


// MARK: - Reflect
open class Reflect: NSObject, NSCoding {

    static var classNameOfString: String {
        return "\(self)"
    }

    var classNameString: String {
        return "\(type(of: self))"
    }

    lazy var mirror: Mirror = { Mirror(reflecting: self) }()

    required override public init() {

    }

    public convenience required init?(coder aDecoder: NSCoder) {

        self.init()

        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()

        self.properties { (name, type, value) -> Void in
            assert(type.check(), "[Charlin Feng]: Property '\(name)' type can not be a '\(type.realType.rawValue)' Type,Please use 'NSNumber' instead!")
            let hasValue = ignorePropertiesForCoding != nil
            if hasValue {
                let ignore = (ignorePropertiesForCoding!).contains(name)
                if !ignore {
                    self.setValue(aDecoder.decodeObject(forKey: name), forKeyPath: name)
                }
            } else {
                self.setValue(aDecoder.decodeObject(forKey: name), forKeyPath: name)
            }
        }
    }

    public func encode(with aCoder: NSCoder) {

        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()
        self.properties { (name, type, value) -> Void in
            let hasValue = ignorePropertiesForCoding != nil
            if hasValue {
                let ignore = (ignorePropertiesForCoding!).contains(name)
                if !ignore {
                    aCoder.encode(value, forKey: name)
                }
            } else {
                if type.isArray {
                    if type.isReflect {
                        aCoder.encode(value as? NSArray, forKey: name)
                    } else {
                        aCoder.encode(value, forKey: name)
                    }
                } else {
                    var v = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "")
                    v = v.replacingOccurrencesOfString(target: "\"", withString: "")
                    aCoder.encode(v, forKey: name)
                }
            }
        }
    }

    override open var description: String {

        let pointAddr = NSString(format: "%p", unsafeBitCast(self, to: Int.self)) as String
        var printStr = self.classNameString + " <\(pointAddr)>: " + "\r{"
        self.properties { (name, type, value) -> Void in
            if type.isArray {
                printStr += "\r\r['\(name)']: \(value)"
            } else {
                printStr += "\r\(name): \(value)"
            }
        }
        printStr += "\r}"

        return printStr
    }

    func properties(property: (_ name: String, _ type: ReflectType, _ value: Any) -> Void) {

        for p in mirror.children {
            let propertyNameString = p.label!
            let v = p.value
            let reflectType = ReflectType(propertyMirrorType: Mirror(reflecting: v), belongType: type(of: self))
            property(propertyNameString, reflectType, v)
        }
    }

    class func properties(property: (_ name: String, _ type: ReflectType, _ value: Any) -> Void) {

        self.init().properties(property: property)
    }

    func parseOver() {

    }

}


// MARK: - Parse
extension Reflect {

    public class func parse(name: String) -> Self? {

        let path = Bundle.main.path(forResource: name + ".plist", ofType: nil)
        if path == nil { return nil }

        let dict = NSDictionary(contentsOfFile: path!)
        if dict == nil { return nil }

        return parse(dict: dict!)
    }

    public class func parse(arr: NSArray) -> [Reflect] {

        var models: [Reflect] = []
        for (_, dict) in arr.enumerated() {
            let model = self.parse(dict: dict as! NSDictionary)
            models.append(model)
        }

        return models
    }

    public class func parse(dict: NSDictionary) -> Self {

        let model = self.init()
        let mappingDict = model.mappingDict()
        let ignoreProperties = model.ignorePropertiesForParse()
        model.properties { (name, type, value) -> Void in
            let dataDictHasKey = dict[name] != nil
            let mappdictDictHasKey = mappingDict?[name] != nil
            let needIgnore = ignoreProperties == nil ? false : (ignoreProperties!).contains(name)
            if (dataDictHasKey || mappdictDictHasKey) && !needIgnore {
                let key = mappdictDictHasKey ? mappingDict![name]! : name
                if !type.isArray {
                    if !type.isReflect {
                        if type.typeClass == Bool.self { //bool
                            model.setValue((dict[key] as AnyObject).boolValue, forKeyPath: name)
                        } else if type.isOptional && type.realType == ReflectType.RealType.String {
                            let v = dict[key]
                            if v != nil {
                                let str_temp = "\(v!)"
                                model.setValue(str_temp, forKeyPath: name)
                            }
                        } else {
                            model.setValue(dict[key], forKeyPath: name)
                        }
                    } else {
                        let dictValue = dict[key]
                        if dictValue != nil {
                            let modelValue = model.value(forKeyPath: key)
                            if modelValue != nil {
                                model.setValue((type.typeClass as! Reflect.Type).parse(dict: dict[key] as! NSDictionary), forKeyPath: name)
                            } else {
                                let tn = type.typeName ?? ""
                                let cls = ClassFromString(str: tn)
                                model.setValue((cls as! Reflect.Type).parse(dict: dict[key] as! NSDictionary), forKeyPath: name)
                            }
                        }
                    }
                } else {
                    if let res = type.isAggregate() {
                        if res is Int.Type {
                            var arrAggregate: [Int] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Int, ins: 0)
                            model.setValue(arrAggregate, forKeyPath: name)

                        } else if res is Float.Type {
                            var arrAggregate: [Float] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Float, ins: 0.0)
                            model.setValue(arrAggregate, forKeyPath: name)

                        } else if res is Double.Type {
                            var arrAggregate: [Double] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Double, ins: 0.0)
                            model.setValue(arrAggregate, forKeyPath: name)

                        } else if res is String.Type {
                            var arrAggregate: [String] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.String, ins: "")
                            model.setValue(arrAggregate, forKeyPath: name)

                        } else if res is NSNumber.Type {
                            var arrAggregate: [NSNumber] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.NSNumber, ins: NSNumber())
                            model.setValue(arrAggregate, forKeyPath: name)

                        } else {
                            var arrAggregate: [AnyObject] = []
                            arrAggregate = dict[key] as! [AnyObject]
                            model.setValue(arrAggregate, forKeyPath: name)
                        }
                    } else {
                        let elementModelType = ReflectType.makeClass(type: type) as! Reflect.Type
                        let dictKeyArr = dict[key] as! NSArray
                        var arrM: [Reflect] = []
                        for (_, value) in dictKeyArr.enumerated() {
                            let elementModel = elementModelType.parse(dict: value as! NSDictionary)
                            arrM.append(elementModel)
                        }
                        model.setValue(arrM, forKeyPath: name)
                    }
                }
            }
        }
        model.parseOver()

        return model
    }

    class func parseAggregateArray<T>(arrDict: NSArray, basicType: ReflectType.BasicType, ins: T) -> [T] {

        var intArrM: [T] = []
        if arrDict.count == 0 { return intArrM }
        for (_, value) in arrDict.enumerated() {
            var element: T = ins
            let v = "\(value)"
            if T.self is Int.Type {
                element = Int(Float(v)!) as! T

            } else if T.self is Float {
                element = v.floatValue as! T

            } else if T.self is Double.Type {
                element = v.doubleValue as! T

            } else if T.self is NSNumber.Type {
                element = NSNumber(value: v.doubleValue!) as! T

            } else if T.self is String.Type {
                element = v as! T

            } else {
                element = value as! T
            }
            intArrM.append(element)
        }

        return intArrM
    }

    func mappingDict() -> [String: String]? {

        return nil
    }

    func ignorePropertiesForParse() -> [String]? {

        return nil
    }

}


// MARK: - Convert
extension Reflect {

    func toDictionary() -> [String: Any] {

        var dict: [String: Any] = [:]
        self.properties { (name, type, value) -> Void in
            if type.isOptional {
                if type.isReflect {
                    dict[name] = (value as? Reflect)?.toDictionary()
                } else {
                    dict[name] = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "").replacingOccurrencesOfString(target: "\"", withString: "")
                }
            } else {
                if type.isReflect {
                    if type.isArray {
                        var dictM: [[String: Any]] = []
                        let modelArr = value as! NSArray
                        for item in modelArr {
                            let dict = (item as! Reflect).toDictionary()
                            dictM.append(dict)
                        }
                        dict[name] = dictM
                    } else {
                        dict[name] = (value as! Reflect).toDictionary()
                    }
                } else {
                    dict[name] = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "").replacingOccurrencesOfString(target: "\"", withString: "")
                }
            }
        }

        return dict
    }

}


// MARK: - Archive
extension Reflect {

    static var DurationKey: String {
        return "Duration"
    }

    class func save(obj: AnyObject!, name: String, duration: TimeInterval) -> String {

        if duration > 0 {
            UserDefaults.standard.set(NSDate().timeIntervalSince1970, forKey: name)
            UserDefaults.standard.set(duration, forKey: name + DurationKey)
        }

        let path = pathWithName(name: name)
        if obj != nil {
            NSKeyedArchiver.archiveRootObject(obj, toFile: path)
        } else {
            let fm = FileManager.default
            if fm.fileExists(atPath: path) {
                if fm.isDeletableFile(atPath: path) {
                    do {
                        try fm.removeItem(atPath: path)
                    } catch {

                    }
                }
            }
        }

        return path
    }

    class func read(name: String) -> (Bool, AnyObject?) {

        let time = UserDefaults.standard.double(forKey: name)
        let duration = UserDefaults.standard.double(forKey: name + DurationKey)
        let now = NSDate().timeIntervalSince1970
        let path = pathWithName(name: name)
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: path)

        if time > 0 && duration > 0 && time + duration < now { return (false, obj as AnyObject?) }
        if obj == nil { return (false, obj as AnyObject?) }

        return (true, obj as AnyObject?)
    }

    class func deleteReflectModel(name: String) {

        _ = save(obj: nil, name: name, duration: 0)
    }

    static func pathWithName(name: String) -> String {

        return Reflect.cachesFolder! + "/" + name + ".arc"
    }

    static var cachesFolder: String? {

        let cacheRootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let cache_reflect_path = cacheRootPath! + "/" + "Reflect"
        let fm = FileManager.default
        let existed = fm.fileExists(atPath: cache_reflect_path)
        if !existed {
            do {
                try fm.createDirectory(atPath: cache_reflect_path, withIntermediateDirectories: true, attributes: nil)
            } catch {}
        }

        return cache_reflect_path
    }

    func ignoreCodingPropertiesForCoding() -> [String]? {

        return nil
    }

}
