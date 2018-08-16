//
//  MaterialColorGroup.swift
//  Mia
//
//  Created by Michael Hedaitulla on 8/2/18.
//

import Foundation

open class MaterialColorGroup: Hashable, Collection {
    
    open let name: String
    open let P50:  MaterialColor
    open let P100: MaterialColor
    open let P200: MaterialColor
    open let P300: MaterialColor
    open let P400: MaterialColor
    open let P500: MaterialColor
    open let P600: MaterialColor
    open let P700: MaterialColor
    open let P800: MaterialColor
    open let P900: MaterialColor
    
    open var colors: [MaterialColor] {
        return [P50, P100, P200, P300, P400, P500, P600, P700, P800, P900]
    }
    open var primaryColor: MaterialColor {
        return P500
    }
    
    open var hashValue: Int {
        return name.hashValue + colors.reduce(0) { $0 + $1.hashValue }
    }
    
    open var startIndex: Int {
        return 0
    }
    open var endIndex: Int {
        return colors.count
    }
    open subscript(i: Int) -> MaterialColor {
        return colors[i]
    }
    /// Returns the position immediately after the given index.
    ///
    /// The successor of an index must be well defined. For an index `i` into a
    /// collection `c`, calling `c.index(after: i)` returns the same index every
    /// time.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    open func index(after i: Int) -> Int {
        if i < self.endIndex {
            return i+1
        }
        return self.endIndex
    }
    
    internal init(name: String,
                  _ P50:  MaterialColor,
                  _ P100: MaterialColor,
                  _ P200: MaterialColor,
                  _ P300: MaterialColor,
                  _ P400: MaterialColor,
                  _ P500: MaterialColor,
                  _ P600: MaterialColor,
                  _ P700: MaterialColor,
                  _ P800: MaterialColor,
                  _ P900: MaterialColor) {
        self.name = name
        
        self.P50  = P50
        self.P100 = P100
        self.P200 = P200
        self.P300 = P300
        self.P400 = P400
        self.P500 = P500
        self.P600 = P600
        self.P700 = P700
        self.P800 = P800
        self.P900 = P900
    }
    
    open func colorForName(_ name: String) -> MaterialColor? {
        return colors.filter { $0.name == name }.first
    }
}

public func ==(lhs: MaterialColorGroup, rhs: MaterialColorGroup) -> Bool {
    return  lhs.name == rhs.name &&
        lhs.colors == rhs.colors
}
