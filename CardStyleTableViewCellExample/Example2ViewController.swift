//
//  Example2ViewController.swift
//  CardStyleTableViewCellExample
//
//  Created by 洪鑫 on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import CardStyleTableViewCell

class Example2ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tableView = tableView as? CardStyleTableView {
            tableView.cardStyleSource = self
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        return cell
    }
    
    //    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    //        return .Delete
    //    }
    //
    //    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
    //        return "Delete"
    //    }
    //
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

extension Example2ViewController: CardStyleTableViewStyleSource {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner {
        return [.AllCorners]
    }
    
    func leftPaddingForCardStyleTableViewCell() -> CGFloat {
        return 10
    }
    
    func rightPaddingForCardStyleTableViewCell() -> CGFloat {
        return 10
    }
    
    func cornerRadiusForCardStyleTableViewCell() -> CGFloat {
        return 6
    }
}

