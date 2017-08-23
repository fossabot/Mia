import UIKit


public protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ sender: CollapsibleTableViewHeader, _ section: Int)
}


open class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

    public var delegate: CollapsibleTableViewHeaderDelegate?
    public var section: Int = 0

    public let titleLabel = UILabel()
    public let arrowLabel = UILabel()

    public init(reuseIdentifier: String?, section: Int, delegate: CollapsibleTableViewHeaderDelegate?) {
        
        self.section = section
        self.delegate = delegate
        
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
        
        contentView.backgroundColor = UIColor(hex6Value: 0x2E3944)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }


    required public init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    public func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {

        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }

        _ = delegate?.toggleSection(self, cell.section)
    }

    public func setCollapsed(_ collapsed: Bool) {

        arrowLabel.rotate(collapsed ? 0.0 : -(.pi / 2))
    }

}


public class CollapsibleTableViewHeaderHelper: UITableViewHeaderFooterView {
    
    public var shouldCollapseByDefault: Bool = false
    
    public var shouldCollapseOthers: Bool = false
    
    
    public var sectionsState = [ Int: Bool ]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        
        if sectionsState.index(forKey: section) == nil {
            sectionsState[section] = shouldCollapseByDefault
        }
        return sectionsState[section]!
    }
    

    
    public func getSectionsNeedReload(_ section: Int) -> [Int] {
        
        var sectionsNeedReload = [ section ]
        
        let isCollapsed = !isSectionCollapsed(section)
        sectionsState[section] = isCollapsed
        
        if !isCollapsed && shouldCollapseOthers {
            let filteredSections = sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            for item in sectionsNeedCollapse { sectionsState[item] = true }
            
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }
}
