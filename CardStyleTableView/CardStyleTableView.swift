//
//  CardStyleTableView.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

extension UITableView {
    public weak var cardStyleSource: CardStyleTableViewStyleSource? {
        get {
            let container = objc_getAssociatedObject(self, &AssociatedKeys.cardStyleTableViewStyleSource) as? WeakObjectContainer
            return container?.object as? CardStyleTableViewStyleSource
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cardStyleTableViewStyleSource, WeakObjectContainer(object: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var leftPadding: CGFloat? {
        return cardStyleSource?.leftPaddingForCardStyleTableView()
    }
    var rightPadding: CGFloat? {
        return cardStyleSource?.rightPaddingForCardStyleTableView()
    }

    // MARK: - Initialize
    public override class func initialize() {
        if self != UITableView.self {
            return
        }
        cardStyle_swizzleTableViewLayoutSubviews()
    }

    // MARK: - Method swizzling
    func cardStyle_tableViewSwizzledLayoutSubviews() {
        cardStyle_tableViewSwizzledLayoutSubviews()

        updateSubviews()
    }

    private class func cardStyle_swizzleTableViewLayoutSubviews() {
        struct CardStyleSwizzleToken {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&CardStyleSwizzleToken.onceToken) {
            let originalSelector = TableViewSelectors.layoutSubviews
            let swizzledSelector = TableViewSelectors.swizzledLayoutSubviews

            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
            print(#function)
        }
    }

    // MARK: - Helper
    private func updateSubviews() {
        guard let leftPadding = leftPadding, rightPadding = rightPadding where style == .Grouped && cardStyleSource != nil else {
            return
        }

        for subview in subviews {
            if NSStringFromClass(subview.dynamicType) == "UITableViewWrapperView" {
                if subview.frame.origin.x != leftPadding {
                    subview.frame.origin.x = leftPadding
                }
                if subview.frame.width != frame.width - leftPadding - rightPadding {
                    subview.frame.size.width = frame.width - leftPadding - rightPadding
                }
            }
            if subview is UITableViewHeaderFooterView {
                if subview.frame.origin.x != leftPadding {
                    subview.frame.origin.x = leftPadding
                }
                if subview.frame.width != frame.width - leftPadding - rightPadding {
                    subview.frame.size.width = frame.width - leftPadding - rightPadding
                }
            }
        }
    }
}
