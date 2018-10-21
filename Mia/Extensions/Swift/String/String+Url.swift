//
//  String+Url.swift
//  Mia
//
//  Created by Michael Hedaitulla on 8/20/18.
//

import Foundation

public extension String{
    
    /// Determine whether the string contains a link.
    ///
    /// - Returns: A bool indication a link was found.
    public var containsLink: Bool{
        guard let regex = RegExpPresets.urlExpression else {
            return false
        }
        let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        return (matches.count > 0) ? true : false
    }
    
    
    /// Extract url links from a string.
    ///
    /// - Returns: Returns a string array containing each links.
    public func extractLinks() -> [String]{
        guard let regex = RegExpPresets.urlExpression else {
            return []
        }
        let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        return matches.map{(self as NSString).substring(with: $0.range)}
    }
}
