//
//  Example2ViewController.swift
//  CardStyleTableViewExample
//
//  Created by 洪鑫 on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import CardStyleTableView

class Example2ViewController: UITableViewController {
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
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

extension Example2ViewController: CardStyleTableViewStyleSource {
    func roundingCornersForCard(inSection section: Int) -> UIRectCorner {
        return [.allCorners]
    }

    func leftPaddingForCardStyleTableView() -> CGFloat {
        return 10
    }

    func rightPaddingForCardStyleTableView() -> CGFloat {
        return 10
    }

    func cornerRadiusForCardStyleTableView() -> CGFloat {
        return 6
    }
}

