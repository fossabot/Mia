//
//  UIColor+Validation.swift
//  Pods
//
//  Created by Michael Hedaitulla on 8/21/17.
//
//

import UIKit


extension UIColor {

    public var isDark: Bool {
        let rgb = rgbaComponents
        return (0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b) < 0.5
    }

    public var isBlackOrWhite: Bool {
        let rgb = rgbaComponents
        return (rgb.r > 0.91 && rgb.g > 0.91 && rgb.b > 0.91) || (rgb.r < 0.09 && rgb.g < 0.09 && rgb.b < 0.09)
    }

    public var isBlack: Bool {
        let rgb = rgbaComponents
        return (rgb.r < 0.09 && rgb.g < 0.09 && rgb.b < 0.09)
    }

    public var isWhite: Bool {
        let rgb = rgbaComponents
        return (rgb.r > 0.91 && rgb.g > 0.91 && rgb.b > 0.91)
    }

    public func isDistinctFrom(_ color: UIColor) -> Bool {

        let bg = rgbaComponents
        let fg = color.rgbaComponents
        let threshold: CGFloat = 0.25
        var result = false

        if fabs(bg.r - fg.r) > threshold || fabs(bg.g - fg.g) > threshold || fabs(bg.b - fg.b) > threshold {
            if fabs(bg.r - bg.g) < 0.03 && fabs(bg.r - bg.b) < 0.03 {
                if fabs(fg.r - fg.g) < 0.03 && fabs(fg.r - fg.b) < 0.03 {
                    result = false
                }
            }
            result = true
        }

        return result
    }

    public func isContrastingWith(_ color: UIColor) -> Bool {

        let bg = rgbaComponents
        let fg = color.rgbaComponents

        let bgLum = 0.2126 * bg.r + 0.7152 * bg.g + 0.0722 * bg.b
        let fgLum = 0.2126 * fg.r + 0.7152 * fg.g + 0.0722 * fg.b
        let contrast = bgLum > fgLum
                ? (bgLum + 0.05) / (fgLum + 0.05)
                : (fgLum + 0.05) / (bgLum + 0.05)

        return 1.6 < contrast
    }

}
