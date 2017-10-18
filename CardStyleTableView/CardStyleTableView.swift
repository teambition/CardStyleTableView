//
//  CardStyleTableView.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

extension UITableView {
    // MARK: - Properties
    public var cardStyleSource: CardStyleTableViewStyleSource? {
        get {
            let container = objc_getAssociatedObject(self, &AssociatedKeys.cardStyleTableViewStyleSource) as? WeakObjectContainer
            return container?.object as? CardStyleTableViewStyleSource
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cardStyleTableViewStyleSource, WeakObjectContainer(object: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    internal var leftPadding: CGFloat? {
        return cardStyleSource?.leftPaddingForCardStyleTableView()
    }
    internal var rightPadding: CGFloat? {
        return cardStyleSource?.rightPaddingForCardStyleTableView()
    }

    // MARK: - Initialize
    internal class func cardStyle_swizzle() {
        if self != UITableView.self {
            return
        }
        cardStyle_swizzleTableViewLayoutSubviews
    }

    // MARK: - Method swizzling
    @objc func cardStyle_tableViewSwizzledLayoutSubviews() {
        cardStyle_tableViewSwizzledLayoutSubviews()

        updateSubviews()
    }

    fileprivate static let cardStyle_swizzleTableViewLayoutSubviews: () = {
        let originalSelector = TableViewSelectors.layoutSubviews
        let swizzledSelector = TableViewSelectors.swizzledLayoutSubviews
        guard let originalMethod = class_getInstanceMethod(UITableView.self, originalSelector), let swizzledMethod = class_getInstanceMethod(UITableView.self, swizzledSelector) else {
            return
        }

        let didAddMethod = class_addMethod(UITableView.self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(UITableView.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        print("cardStyle_swizzleTableViewLayoutSubviews")
    }()

    // MARK: - Helper
    fileprivate func updateSubviews() {
        guard let leftPadding = leftPadding, let rightPadding = rightPadding, style == .grouped && cardStyleSource != nil else {
            return
        }

        subviews.forEach {
            if $0 is UITableViewHeaderFooterView {
                if $0.frame.origin.x != leftPadding {
                    $0.frame.origin.x = leftPadding
                }
                if $0.frame.width != frame.width - leftPadding - rightPadding {
                    $0.frame.size.width = frame.width - leftPadding - rightPadding
                }
            }
        }
    }
}
