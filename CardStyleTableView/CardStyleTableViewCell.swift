//
//  CardStyleTableViewCell.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

extension UITableViewCell {
    // MARK: - Properties
    fileprivate var tableView: UITableView? {
        get {
            let container = objc_getAssociatedObject(self, &AssociatedKeys.cardStyleTableViewCellTableView) as? WeakObjectContainer
            return container?.object as? UITableView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cardStyleTableViewCellTableView, WeakObjectContainer(object: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateFrame()
        }
    }
    fileprivate var indexPath: IndexPath? {
        guard let tableView = tableView else {
            return nil
        }
        return tableView.indexPath(for: self) ?? tableView.indexPathForRow(at: center)
    }
    fileprivate var indexPathLocation: (isFirstRowInSection: Bool, isLastRowInSection: Bool) {
        guard let tableView = tableView, let indexPath = indexPath else {
            return (false, false)
        }
        let isFirstRowInSection = indexPath.row == 0
        let isLastRowInSection = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        return (isFirstRowInSection, isLastRowInSection)
    }

    // MARK: - Initialize
    internal class func cardStyle_swizzle() {
        if self != UITableViewCell.self {
            return
        }
        cardStyle_swizzleTableViewCellLayoutSubviews
        cardStyle_swizzleTableViewCellDidMoveToSuperview
    }

    // MARK: - Method swizzling
    @objc func cardStyle_tableViewCellSwizzledLayoutSubviews() {
        cardStyle_tableViewCellSwizzledLayoutSubviews()

        updateFrame()
        setRoundingCorners()
    }

    @objc func cardStyle_tableViewCellSwizzledDidMoveToSuperview() {
        cardStyle_tableViewCellSwizzledDidMoveToSuperview()

        tableView = nil
        if let tableView = superview as? UITableView {
            self.tableView = tableView
        } else if let tableView = superview?.superview as? UITableView {
            self.tableView = tableView
        }
    }

    fileprivate class func cardStyle_swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(aClass, originalSelector), let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector) else {
            return
        }

        let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    fileprivate static let cardStyle_swizzleTableViewCellLayoutSubviews: () = {
        let originalSelector = TableViewCellSelectors.layoutSubviews
        let swizzledSelector = TableViewCellSelectors.swizzledLayoutSubviews

        cardStyle_swizzleMethod(for: UITableViewCell.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
        print("cardStyle_swizzleTableViewCellLayoutSubviews")
    }()

    fileprivate static let cardStyle_swizzleTableViewCellDidMoveToSuperview: () = {
        let originalSelector = TableViewCellSelectors.didMoveToSuperview
        let swizzledSelector = TableViewCellSelectors.swizzledDidMoveToSuperview

        cardStyle_swizzleMethod(for: UITableViewCell.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
        print("cardStyle_swizzleTableViewCellDidMoveToSuperview")
    }()

    // MARK: - Helper
    fileprivate func updateFrame() {
        guard let tableView = tableView, tableView.style == .grouped && tableView.cardStyleSource != nil else {
            return
        }
        guard let leftPadding = tableView.leftPadding, let rightPadding = tableView.rightPadding else {
            return
        }

        var needsLayout = false
        if frame.origin.x != leftPadding {
            frame.origin.x = leftPadding
            needsLayout = true
        }
        if frame.width != tableView.frame.width - leftPadding - rightPadding {
            frame.size.width = tableView.frame.width - leftPadding - rightPadding
            needsLayout = true
        }

        if #available(iOS 10.0, *), needsLayout {
            layoutIfNeeded()
        }
    }

    fileprivate func setRoundingCorners() {
        guard let tableView = tableView, let indexPath = indexPath, tableView.style == .grouped && tableView.cardStyleSource != nil else {
            layer.mask = nil
            return
        }
        var roundingCorners = tableView.cardStyleSource?.roundingCornersForCard(inSection: indexPath.section) ?? UIRectCorner.allCorners
        guard let cornerRadius = tableView.cardStyleSource?.cornerRadiusForCardStyleTableView(), roundingCorners != [] else {
            layer.mask = nil
            return
        }

        let maskLayer = CAShapeLayer()
        let maskRect = bounds
        maskLayer.frame = maskRect
        let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)

        switch indexPathLocation {
        case (true, true):
            let maskPath = UIBezierPath(roundedRect: maskRect, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        case (true, false):
            let firstRowCorners: UIRectCorner = {
                if roundingCorners == .allCorners {
                    return [.topLeft, .topRight]
                } else {
                    roundingCorners.remove(.bottomLeft)
                    roundingCorners.remove(.bottomRight)
                    return roundingCorners
                }
            }()
            let maskPath = UIBezierPath(roundedRect: maskRect, byRoundingCorners: firstRowCorners, cornerRadii: cornerRadii)
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        case (false, true):
            let lastRowCorners: UIRectCorner = {
                if roundingCorners == .allCorners {
                    return [.bottomLeft, .bottomRight]
                } else {
                    roundingCorners.remove(.topLeft)
                    roundingCorners.remove(.topRight)
                    return roundingCorners
                }
            }()
            let maskPath = UIBezierPath(roundedRect: maskRect, byRoundingCorners: lastRowCorners, cornerRadii: cornerRadii)
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        default:
            layer.mask = nil
        }
    }
}
