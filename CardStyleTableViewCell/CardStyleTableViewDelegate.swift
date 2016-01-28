//
//  CardStyleTableViewDelegate.swift
//  CardStyleTableViewCell
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public protocol CardStyleTableViewStyleSource {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner
    func leftPaddingForCardStyleTableViewCell() -> CGFloat
    func rightPaddingForCardStyleTableViewCell() -> CGFloat
    func cornerRadiusForCardStyleTableViewCell() -> CGFloat
}

public extension CardStyleTableViewStyleSource {
    func roundingCornersForCardInSection(section: Int) -> UIRectCorner {
        return UIRectCorner.AllCorners
    }
}