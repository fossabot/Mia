//
//  MaterialColor.swift
//  Alamofire
//
//  Created by Michael Hedaitulla on 8/2/18.
//

import Foundation


public struct MaterialColor: Hashable {
    public let name: String
    public let color: UIColor
    public let textColor: UIColor
    
    public var hashValue: Int {
        return name.hashValue + color.hashValue + textColor.hashValue
    }
    
    internal init(name: String, color: UIColor, textColor: UIColor) {
        self.name = name
        self.color = color
        self.textColor = textColor
    }
    
    internal init(name: String, color: UInt, textColor: UInt) {
        self.init(name: name, color: UIColor(rgba: color), textColor: UIColor(rgba: textColor))
    }
}

public func ==(lhs: MaterialColor, rhs: MaterialColor) -> Bool {
    return  lhs.name == rhs.name &&
        lhs.color == rhs.color &&
        lhs.textColor == rhs.textColor
}
