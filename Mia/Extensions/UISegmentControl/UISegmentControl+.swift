public extension UISegmentedControl {

    public var selectedTitle: String {
        return self.titleForSegment(at: self.selectedSegmentIndex) ?? ""
    }
}
