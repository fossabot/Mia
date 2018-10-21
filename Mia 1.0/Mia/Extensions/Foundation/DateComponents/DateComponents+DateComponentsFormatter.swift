//
//  DateComponents+DateComponentsFormatter.swift
//  Mia
//
//  Created by Michael Hedaitulla on 3/4/18.
//

import Foundation

extension DateComponents {

    /// Creates a `String` instance representing the receiver formatted in given units style.
    ///
    /// - parameter unitsStyle: The units style.
    ///
    /// - returns: The created a `String` instance.
    public func string(in unitsStyle: DateComponentsFormatter.UnitsStyle) -> String? {

        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = unitsStyle
        dateComponentsFormatter.allowedUnits = [ .year, .month, .weekOfMonth, .day /*, .hour, .minute, .second*/ ]

        return dateComponentsFormatter.string(from: self)
    }
}
