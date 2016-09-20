//
//  Example1ViewController.swift
//  CardStyleTableViewExample
//
//  Created by 洪鑫 on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import CardStyleTableView

class Example1ViewController: UITableViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cardStyleSource = self
    }

    // MARK: - Table view data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        let remainder = indexPath.section % 5
        switch remainder {
        case 0:
            cell!.accessoryType = .disclosureIndicator
        case 1:
            cell!.accessoryType = .checkmark
        case 2:
            cell!.accessoryType = .detailButton
        case 3:
            cell!.accessoryType = .detailDisclosureButton
        default:
            cell!.accessoryType = .none
        }
        cell?.textLabel?.text = "Cell"
        cell?.detailTextLabel?.text = "Row \(indexPath.row), Section \(indexPath.section)"

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension Example1ViewController: CardStyleTableViewStyleSource {
    func roundingCornersForCard(inSection section: Int) -> UIRectCorner {
        return [.allCorners]
    }
    
    func leftPaddingForCardStyleTableView() -> CGFloat {
        return 20
    }
    
    func rightPaddingForCardStyleTableView() -> CGFloat {
        return 20
    }
    
    func cornerRadiusForCardStyleTableView() -> CGFloat {
        return 8
    }
}
