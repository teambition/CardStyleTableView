//
//  CardStyleTableViewCell.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

extension UITableViewCell {
    private var tableView: UITableView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cardStyleTableViewCellTableView) as? UITableView
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.cardStyleTableViewCellTableView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    private var indexPath: NSIndexPath? {
        guard let tableView = tableView else {
            return nil
        }
        return tableView.indexPathForCell(self) ?? tableView.indexPathForRowAtPoint(center)
    }
    private var indexPathLocation: (isFirstRowInSection: Bool, isLastRowInSection: Bool) {
        guard let tableView = tableView, let indexPath = indexPath else {
            return (false, false)
        }
        let isFirstRowInSection = indexPath.row == 0
        let isLastRowInSection = indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1
        return (isFirstRowInSection, isLastRowInSection)
    }

    // MARK: - Initialize
    public override class func initialize() {
        if self != UITableViewCell.self {
            return
        }
        cardStyle_swizzleTableViewCellLayoutSubviews()
        cardStyle_swizzleTableViewCellDidMoveToSuperview()
    }

    // MARK: - Method swizzling
    func cardStyle_tableViewCellSwizzledLayoutSubviews() {
        cardStyle_tableViewCellSwizzledLayoutSubviews()

        updateFrame()
        setRoundingCorners()
    }

    func cardStyle_tableViewCellSwizzledDidMoveToSuperview() {
        cardStyle_tableViewCellSwizzledDidMoveToSuperview()

        tableView = nil
        if let tableView = superview as? UITableView {
            self.tableView = tableView
        } else if let tableView = superview?.superview as? UITableView {
            self.tableView = tableView
        }
    }

    private class func cardStyle_swizzleMethod(originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    private class func cardStyle_swizzleTableViewCellLayoutSubviews() {
        struct CardStyleSwizzleToken {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&CardStyleSwizzleToken.onceToken) {
            let originalSelector = Selectors.layoutSubviews
            let swizzledSelector = Selectors.tableViewCellSwizzledLayoutSubviews

            cardStyle_swizzleMethod(originalSelector, swizzledSelector: swizzledSelector)
            print(__FUNCTION__)
        }
    }

    private class func cardStyle_swizzleTableViewCellDidMoveToSuperview() {
        struct CardStyleSwizzleToken {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&CardStyleSwizzleToken.onceToken) {
            let originalSelector = Selectors.didMoveToSuperview
            let swizzledSelector = Selectors.tableViewCellSwizzledDidMoveToSuperview

            cardStyle_swizzleMethod(originalSelector, swizzledSelector: swizzledSelector)
            print(__FUNCTION__)
        }
    }

    // MARK: - Helper
    private func updateFrame() {
        guard let tableView = tableView, let wrapperView = superview where tableView.style == .Grouped && tableView.cardStyleSource != nil else {
            return
        }
        if frame.width != wrapperView.frame.width {
            frame.size.width = wrapperView.frame.width
        }
    }

    private func setRoundingCorners() {
        guard let tableView = tableView, let indexPath = indexPath where tableView.style == .Grouped && tableView.cardStyleSource != nil else {
            layer.mask = nil
            return
        }
        var roundingCorners = tableView.cardStyleSource?.roundingCornersForCardInSection(indexPath.section) ?? UIRectCorner.AllCorners
        guard let cornerRadius = tableView.cardStyleSource?.cornerRadiusForCardStyleTableView() where roundingCorners != [] else {
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
            maskLayer.path = maskPath.CGPath
            layer.mask = maskLayer
        case (true, false):
            let firstRowCorners: UIRectCorner = {
                if roundingCorners == .AllCorners {
                    return [.TopLeft, .TopRight]
                } else {
                    roundingCorners.remove(.BottomLeft)
                    roundingCorners.remove(.BottomRight)
                    return roundingCorners
                }
            }()
            let maskPath = UIBezierPath(roundedRect: maskRect, byRoundingCorners: firstRowCorners, cornerRadii: cornerRadii)
            maskLayer.path = maskPath.CGPath
            layer.mask = maskLayer
        case (false, true):
            let lastRowCorners: UIRectCorner = {
                if roundingCorners == .AllCorners {
                    return [.BottomLeft, .BottomRight]
                } else {
                    roundingCorners.remove(.TopLeft)
                    roundingCorners.remove(.TopRight)
                    return roundingCorners
                }
            }()
            let maskPath = UIBezierPath(roundedRect: maskRect, byRoundingCorners: lastRowCorners, cornerRadii: cornerRadii)
            maskLayer.path = maskPath.CGPath
            layer.mask = maskLayer
        default:
            layer.mask = nil
        }
    }
}
