import UIKit


// MARK: - CollapsibleTableSectionDelegate

@objc public protocol CollapsibleTableSectionDelegate {

    @objc optional func numberOfSections(_ tableView: UITableView) -> Int


    @objc optional func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int


    @objc optional func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell


    @objc optional func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)


    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat


    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat


    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat


    @objc optional func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?


    @objc optional func shouldCollapseByDefault(_ tableView: UITableView) -> Bool


    @objc optional func shouldCollapseOthers(_ tableView: UITableView) -> Bool
}


// MARK: - View Controller

open class CollapsibleTableSectionViewController: UIViewController {

    public var delegate: CollapsibleTableSectionDelegate?

    fileprivate var _tableView: UITableView!

    fileprivate var _sectionsState = [ Int: Bool ]()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView!.dataSource = self
            tableView!.delegate = self

            tableView!.estimatedRowHeight = 44.0
            tableView!.rowHeight = UITableViewAutomaticDimension
        }
    }


    public func isSectionCollapsed(_ section: Int) -> Bool {

        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = delegate?.shouldCollapseByDefault?(tableView ?? _tableView!) ?? false
        }
        return _sectionsState[section]!
    }


    func getSectionsNeedReload(_ section: Int) -> [Int] {

        var sectionsNeedReload = [ section ]

        let isCollapsed = !isSectionCollapsed(section)
        _sectionsState[section] = isCollapsed

        let shouldCollapseOthers = delegate?.shouldCollapseOthers?(tableView ?? _tableView!) ?? false

        if !isCollapsed && shouldCollapseOthers {
            let filteredSections = _sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }

            for item in sectionsNeedCollapse { _sectionsState[item] = true }

            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }

        return sectionsNeedReload
    }


    override open func viewDidLoad() {

        super.viewDidLoad()

        if tableView == nil {

            _tableView = UITableView()
            _tableView.dataSource = self
            _tableView.delegate = self

            _tableView.estimatedRowHeight = 44.0
            _tableView.rowHeight = UITableViewAutomaticDimension

            view.addSubview(_tableView)
            _tableView.translatesAutoresizingMaskIntoConstraints = false
            _tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
            _tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
            _tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            _tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    }

}


// MARK: - View Controller DataSource and Delegate

extension CollapsibleTableSectionViewController: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {

        return delegate?.numberOfSections?(tableView) ?? 1
    }


    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let numberOfRows = delegate?.collapsibleTableView?(tableView, numberOfRowsInSection: section) ?? 0
        return isSectionCollapsed(section) ? 0 : numberOfRows
    }


    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return delegate?.collapsibleTableView?(tableView, cellForRowAt: indexPath) ?? UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DefaultCell")
    }


    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return delegate?.collapsibleTableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }


    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.collapsibleTableView?(tableView, didSelectRowAt: indexPath)
    }


    // Header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ??
                     CollapsibleTableViewHeader(reuseIdentifier: "header", section: section, delegate: self)

        let title = delegate?.collapsibleTableView?(tableView, titleForHeaderInSection: section) ?? ""

        header.titleLabel.text = title
        header.arrowLabel.text = ">"
        header.setCollapsed(isSectionCollapsed(section))

        header.section = section
        header.delegate = self

        return header
    }


    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return delegate?.collapsibleTableView?(tableView, heightForHeaderInSection: section) ?? 30.0
    }


    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return delegate?.collapsibleTableView?(tableView, heightForFooterInSection: section) ?? 0.0
    }

}


// MARK: - Section Header Delegate

extension CollapsibleTableSectionViewController: CollapsibleTableViewHeaderDelegate {
    public func toggleSection(_ section: Int) {

        let sectionsNeedReload = getSectionsNeedReload(section)
        (tableView ?? _tableView!).reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }

}