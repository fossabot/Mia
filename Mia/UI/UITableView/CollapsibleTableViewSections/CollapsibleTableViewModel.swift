import UIKit


public struct CollapsibleTableViewModel {
    public var name: String

    public var items: [Any]


    public init(name: String, items: [Any]) {

        self.name = name
        self.items = items
    }
}
