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

struct Selectors {
    static let layoutSubviews: Selector = "layoutSubviews"
    static let didMoveToSuperview: Selector = "didMoveToSuperview"
    static let tableViewSwizzledLayoutSubviews: Selector = "cardStyle_tableViewSwizzledLayoutSubviews"
    static let tableViewCellSwizzledLayoutSubviews: Selector = "cardStyle_tableViewCellSwizzledLayoutSubviews"
    static let tableViewCellSwizzledDidMoveToSuperview: Selector = "cardStyle_tableViewCellSwizzledDidMoveToSuperview"
}
