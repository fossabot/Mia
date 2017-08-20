import UIKit


protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ section: Int)
}


open class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0

    let titleLabel = UILabel()
    let arrowLabel = UILabel()

    override public init(reuseIdentifier: String?) {

        super.init(reuseIdentifier: reuseIdentifier)

        let marginGuide = contentView.layoutMarginsGuide

        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true

        contentView.backgroundColor = UIColor(hex: 0x2E3944)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }

    required public init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {

        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }

        _ = delegate?.toggleSection(cell.section)
    }

    func setCollapsed(_ collapsed: Bool) {

        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }

}



