//
//  Constants.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var cardStyleTableViewStyleSource = "CardStyleTableViewStyleSource"
    static var cardStyleTableViewCellTableView = "CardStyleTableViewCellTableView"
}

struct TableViewSelectors {
    static let layoutSubviews = #selector(UITableView.layoutSubviews)
    static let swizzledLayoutSubviews = #selector(UITableView.cardStyle_tableViewSwizzledLayoutSubviews)
}

struct TableViewCellSelectors {
    static let layoutSubviews = #selector(UITableViewCell.layoutSubviews)
    static let didMoveToSuperview = #selector(UITableViewCell.didMoveToSuperview)
    static let swizzledLayoutSubviews = #selector(UITableViewCell.cardStyle_tableViewCellSwizzledLayoutSubviews)
    static let swizzledDidMoveToSuperview = #selector(UITableViewCell.cardStyle_tableViewCellSwizzledDidMoveToSuperview)
}
