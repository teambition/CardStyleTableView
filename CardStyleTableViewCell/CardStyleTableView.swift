//
//  CardStyleTableView.swift
//  CardStyleTableViewCell
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public class CardStyleTableView: UITableView {
    public var cardStyleSource: CardStyleTableViewStyleSource?

    private var leftPadding: CGFloat {
        return cardStyleSource?.leftPaddingForCardStyleTableViewCell() ?? 0
    }
    private var rightPadding: CGFloat {
        return cardStyleSource?.rightPaddingForCardStyleTableViewCell() ?? 0
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateSubviews()
    }

    private func updateSubviews() {
        for subview in subviews {
            if NSStringFromClass(subview.dynamicType) == "UITableViewWrapperView" {
                subview.frame.origin.x = leftPadding
                subview.frame.size.width = frame.width - leftPadding - rightPadding
            }
            if subview is UITableViewHeaderFooterView {
                subview.frame.origin.x = leftPadding
                subview.frame.size.width = frame.width - leftPadding - rightPadding
            }
        }
    }
}
