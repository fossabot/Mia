//
//  MaterialColorGroupWithAccents.swift
//  Mia
//
//  Created by Michael Hedaitulla on 8/2/18.
//

import Foundation

open class MaterialColorGroupWithAccents: MaterialColorGroup {
    open let A100: MaterialColor
    open let A200: MaterialColor
    open let A400: MaterialColor
    open let A700: MaterialColor
    
    open var accents: [MaterialColor] {
        return [A100, A200, A400, A700]
    }
    
    open override var hashValue: Int {
        return super.hashValue + accents.reduce(0) { $0 + $1.hashValue }
    }
    
    open override var endIndex: Int {
        return colors.count + accents.count
    }
    open override subscript(i: Int) -> MaterialColor {
        return (colors + accents)[i]
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
                  _ P900: MaterialColor,
                  _ A100: MaterialColor,
                  _ A200: MaterialColor,
                  _ A400: MaterialColor,
                  _ A700: MaterialColor
        ) {
        self.A100 = A100
        self.A200 = A200
        self.A400 = A400
        self.A700 = A700
        
        super.init(name: name, P50, P100, P200, P300, P400, P500, P600, P700, P800, P900)
    }
    
    open override func colorForName(_ name: String) -> MaterialColor? {
        return (colors + accents).filter { $0.name == name}.first
    }
}

func ==(lhs: MaterialColorGroupWithAccents, rhs: MaterialColorGroupWithAccents) -> Bool {
    return (lhs as MaterialColorGroup) == (rhs as MaterialColorGroup) &&
        lhs.accents == rhs.accents
}
