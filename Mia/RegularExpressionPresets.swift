//
//  RegularExpressionPresets.swift
//  Mia
//
//  Created by Michael Hedaitulla on 8/20/18.
//

import Foundation


public typealias RegExpPresets = RegularExpressionPresets
public struct RegularExpressionPresets {
    
    public static var urlExpression: NSRegularExpression? {
        if let regex = try? NSRegularExpression(pattern: "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?" , options: []) {
            return regex
        }
        return nil
    }
    
}
