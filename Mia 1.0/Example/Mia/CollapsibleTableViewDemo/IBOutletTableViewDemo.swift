import UIKit
import Mia


class IBOutletTableViewDemo: CollapsibleTableSectionViewController {

    var sections: [Section] = sectionsData

    override func viewDidLoad() {

        super.viewDidLoad()
        self.delegate = self
    }

}


extension IBOutletTableViewDemo: CollapsibleTableSectionDelegate {

    func numberOfSections(_ tableView: UITableView) -> Int {

        return sections.count
    }

    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sections[section].items.count
    }

    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item: Item = sections[indexPath.section].items[indexPath.row] as! Item

        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.detail

        return cell
    }

    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section].name
    }

}



