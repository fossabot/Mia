import UIKit
import Mia


class DefaultTableViewDemo: CollapsibleTableSectionViewController {

    var sections: [Section] = sectionsData
    var runOnce = true
    override func viewDidLoad() {

        super.viewDidLoad()
        self.delegate = self
        

    }

}


extension DefaultTableViewDemo: CollapsibleTableSectionDelegate {

    func numberOfSections(_ tableView: UITableView) -> Int {

        if runOnce {
            let blurredBackgroundView = BlurredBackgroundView(style: .extraLight, image: UIImage(named: "tableViewBG"))
            tableView.backgroundView = blurredBackgroundView
            tableView.separatorEffect = blurredBackgroundView.separatorEffect
            runOnce = false
        }
        
        return sections.count
    }

    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sections[section].items.count
    }

    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item: Item = sections[indexPath.section].items[indexPath.row] as! Item

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BasicCell")
        cell.backgroundColor = .clear
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.detail

        return cell
    }

    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section].name
    }

}


