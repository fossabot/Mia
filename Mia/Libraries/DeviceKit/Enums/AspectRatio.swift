public enum AspectRatio {

    case unknown
    case _3x2
    case _4x3
    case _16x9

    public var description: String {
        switch self {
            case ._3x2: return "3 x 2"
            case ._4x3:   return "4 x 3"
            case ._16x9: return "16 x 9"
            case .unknown:  return "Unknown Aspect Ratio"
        }
    }

    public var size: CGSize {
        switch self {
            case ._3x2: return CGSize(width: 3, height: 2)
            case ._4x3:   return CGSize(width: 4, height: 3)
            case ._16x9: return CGSize(width: 16, height: 9)
            case .unknown:  return .zero
        }
    }

}
