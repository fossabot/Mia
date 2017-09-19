import UIKit


public enum PageSize {

    case `default`
    case letter, governmentLetter
    case legal, juniorLegal
    case ledger, tabloid
    case a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10
    case b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10
    case c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10
    case japaneseB0, japaneseB1, japaneseB2, japaneseB3, japaneseB4, japaneseB5, japaneseB6
    case japaneseB7, japaneseB8, japaneseB9, japaneseB10, japaneseB11, japaneseB12
    case custom(width: CGFloat, height: CGFloat)

    static func makeSizeWithPPI(_ width: Double, _ height: Double) -> CGSize {

        let ppi: Double = 72
        return CGSize(width: width * ppi, height: height * ppi)

    }

    static func size(for pageSize: PageSize) -> CGSize {

        switch pageSize {
            case `default`: return PageSize.size(for: (NSLocale.current.usesMetricSystem ? .a4 : .letter))
            case letter: return makeSizeWithPPI(8.5, 11.0)
            case governmentLetter: return makeSizeWithPPI(8.0, 10.5)
            case legal: return makeSizeWithPPI(8.5, 14.0)
            case juniorLegal: return makeSizeWithPPI(8.5, 5.0)
            case ledger: return makeSizeWithPPI(17.0, 11.0)
            case tabloid: return makeSizeWithPPI(11.0, 17.0)
            case a0: return makeSizeWithPPI(33.11, 46.81)
            case a1: return makeSizeWithPPI(23.39, 33.11)
            case a2: return makeSizeWithPPI(16.54, 23.39)
            case a3: return makeSizeWithPPI(11.69, 16.54)
            case a4: return makeSizeWithPPI(8.26666667, 11.6916667)
            case a5: return makeSizeWithPPI(5.83, 8.27)
            case a6: return makeSizeWithPPI(4.13, 5.83)
            case a7: return makeSizeWithPPI(2.91, 4.13)
            case a8: return makeSizeWithPPI(2.05, 2.91)
            case a9: return makeSizeWithPPI(1.46, 2.05)
            case a10: return makeSizeWithPPI(1.02, 1.46)
            case b0: return makeSizeWithPPI(39.37, 55.67)
            case b1: return makeSizeWithPPI(27.83, 39.37)
            case b2: return makeSizeWithPPI(19.69, 27.83)
            case b3: return makeSizeWithPPI(13.90, 19.69)
            case b4: return makeSizeWithPPI(9.84, 13.90)
            case b5: return makeSizeWithPPI(6.93, 9.84)
            case b6: return makeSizeWithPPI(4.92, 6.93)
            case b7: return makeSizeWithPPI(3.46, 4.92)
            case b8: return makeSizeWithPPI(2.44, 3.46)
            case b9: return makeSizeWithPPI(1.73, 2.44)
            case b10: return makeSizeWithPPI(1.22, 1.73)
            case c0: return makeSizeWithPPI(36.10, 51.06)
            case c1: return makeSizeWithPPI(25.51, 36.10)
            case c2: return makeSizeWithPPI(18.03, 25.51)
            case c3: return makeSizeWithPPI(12.76, 18.03)
            case c4: return makeSizeWithPPI(9.02, 12.76)
            case c5: return makeSizeWithPPI(6.38, 9.02)
            case c6: return makeSizeWithPPI(4.49, 6.38)
            case c7: return makeSizeWithPPI(3.19, 4.49)
            case c8: return makeSizeWithPPI(2.24, 3.19)
            case c9: return makeSizeWithPPI(1.57, 2.24)
            case c10: return makeSizeWithPPI(1.10, 1.57)
            case japaneseB0: return makeSizeWithPPI(40.55, 57.32)
            case japaneseB1: return makeSizeWithPPI(28.66, 40.55)
            case japaneseB2: return makeSizeWithPPI(20.28, 28.66)
            case japaneseB3: return makeSizeWithPPI(14.33, 20.28)
            case japaneseB4: return makeSizeWithPPI(10.12, 14.33)
            case japaneseB5: return makeSizeWithPPI(7.17, 10.12)
            case japaneseB6: return makeSizeWithPPI(5.04, 7.17)
            case japaneseB7: return makeSizeWithPPI(3.58, 5.04)
            case japaneseB8: return makeSizeWithPPI(2.52, 3.58)
            case japaneseB9: return makeSizeWithPPI(1.77, 2.52)
            case japaneseB10: return makeSizeWithPPI(1.26, 1.77)
            case japaneseB11: return makeSizeWithPPI(0.87, 1.26)
            case japaneseB12: return makeSizeWithPPI(0.63, 0.87)
            case custom(let width, let height): return makeSizeWithPPI(Double(width), Double(height))

        }
    }

}
