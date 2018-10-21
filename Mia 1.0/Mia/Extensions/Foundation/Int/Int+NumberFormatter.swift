//
//  Int+NumberFormatter.swift
//  Mia
//
//  Created by Michael Hedaitulla on 3/4/18.
//

import Foundation

extension Int {

    public var ordinal: String {
        return NumberFormatter.cachedFormatter(.ordinal).string(from: NSNumber(value: self))!
    }
}
