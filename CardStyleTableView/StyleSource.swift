//
//  StyleSource.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public protocol CardStyleTableViewStyleSource: NSObjectProtocol {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner
    func leftPaddingForCardStyleTableView() -> CGFloat
    func rightPaddingForCardStyleTableView() -> CGFloat
    func cornerRadiusForCardStyleTableView() -> CGFloat
}

public extension CardStyleTableViewStyleSource {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner {
        return UIRectCorner.AllCorners
    }
}