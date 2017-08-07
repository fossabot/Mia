import Foundation


func ClassFromString(str: String) -> AnyClass! {

    if var appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {

        if appName == "" { appName = ((Bundle.main.bundleIdentifier!).characters.split { $0 == "." }.map { String($0) }).last ?? "" }

        var clsStr = str

        if !str.contain(subStr: "\(appName).") {
            clsStr = appName + "." + str
        }

        let strArr = clsStr.explode(separator: ".")

        var className = ""

        let num = strArr.count
        if num > 2 || strArr.contains(appName) {

            var nameStringM = "_TtC" + "C".repeatTimes(times: num - 2)

            for (_, s): (Int, String) in strArr.enumerated() {
                nameStringM += "\(s.characters.count)\(s)"
            }

            className = nameStringM

        } else {

            className = clsStr
        }

        let cls = NSClassFromString(className)

        return cls
    }

    return nil;
}


extension String {

    var floatValue: Float? {
        return NumberFormatter().number(from: self)?.floatValue
    }

    var doubleValue: Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

    func contain(subStr: String) -> Bool {

        return (self as NSString).range(of: subStr).length > 0
    }

    func explode(separator: Character) -> [String] {

        return self.characters.split(whereSeparator: { (element) -> Bool in

            return element == separator
        }).map { String($0) }

    }

    func replacingOccurrencesOfString(target: String, withString: String) -> String {

        return (self as NSString).replacingOccurrences(of: target, with: withString)
    }

    func deleteSpecialStr() -> String {

        return self.replacingOccurrencesOfString(target: "Optional<", withString: "").replacingOccurrencesOfString(target: ">", withString: "")
    }

    func repeatTimes(times: Int) -> String {

        var strM = ""
        for _ in 0..<times {
            strM += self
        }

        return strM
    }

}
