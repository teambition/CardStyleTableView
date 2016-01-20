//
//  Example1ViewController.swift
//  CardStyleTableViewCellExample
//
//  Created by 洪鑫 on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import CardStyleTableViewCell

class Example1ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? CardStyleTableViewCell
        if cell == nil {
            cell = CardStyleTableViewCell(style: .Value1, reuseIdentifier: "Cell")
        }
        
        let remainder = indexPath.section % 5
        switch remainder {
        case 0:
            cell!.accessoryType  = .DisclosureIndicator
        case 1:
            cell!.accessoryType  = .Checkmark
        case 2:
            cell!.accessoryType  = .DetailButton
        case 3:
            cell!.accessoryType  = .DetailDisclosureButton
        default:
            cell!.accessoryType  = .None
        }
        cell?.cardStyleDelegate = self
        cell?.textLabel?.text = "Cell"
        cell?.detailTextLabel?.text = "Row \(indexPath.row), Section \(indexPath.section)"

        return cell!
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

extension Example1ViewController: CardStyleTableViewCellDelegate {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner {
        return [.AllCorners]
    }
    
    func leftPaddingForCardStyleTableViewCell() -> CGFloat {
        return 20
    }
    
    func rightPaddingForCardStyleTableViewCell() -> CGFloat {
        return 20
    }
    
    func cornerRadiusForCardStyleTableViewCell() -> CGFloat {
        return 8
    }
}
