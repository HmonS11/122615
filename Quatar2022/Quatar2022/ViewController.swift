//
//  ViewController.swift
//  Qatar2022
//
//  Created by wizard on 2022/10/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func getKey(section:Int) -> String {
        let keys = groups.keys.sorted() //["A", "B", "C",...."H"]
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let keys = groups.keys.sorted() //["A", "B", "C",...."H"]
//        let key =  keys[section]
        
        let key = getKey(section: section)
        if let group = groups[key] {
            return group.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let key = getKey(section: indexPath.section)
        guard let group = groups[key] else { fatalError() }
        let dic = group[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        guard let cell = cell else { fatalError() }
        var content = cell.defaultContentConfiguration()
        content.text = dic["country"]
        content.textProperties.font = .systemFont(ofSize: 25, weight: .bold)
        if let flag = dic["flag"]{
            content.image = UIImage(named: flag)
        } else {
            content.image = UIImage(systemName: "egg")
        }
        content.imageProperties.maximumSize.width = 100
        content.imageProperties.maximumSize.height = 80
        content.secondaryText = "Group \(key)"
        content.secondaryTextProperties.color = .red
        cell.contentConfiguration = content
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let key = getKey(section: section)
        label.text = "Group \(key)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.backgroundColor = .lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

