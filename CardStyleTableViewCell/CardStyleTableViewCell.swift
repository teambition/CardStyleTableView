//
//  CardStyleTableViewCell.swift
//  CardStyleTableViewCell
//
//  Created by Xin Hong on 16/1/20.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public class CardStyleTableViewCell: UITableViewCell {
    private var tableView: CardStyleTableView?
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
    private var maskLayer = CAShapeLayer()

    // MARK: - Life cycle
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
        setRoundingCorners()
    }

    public override func didMoveToSuperview() {
        tableView = nil
        if let tableView = superview as? CardStyleTableView {
            self.tableView = tableView
        } else if let tableView = superview?.superview as? CardStyleTableView {
            self.tableView = tableView
        }
    }

    // MARK: - Helper
    private func updateFrame() {
        guard let tableView = tableView, let wrapperView = superview where tableView.style == .Grouped else {
            return
        }
        frame.size.width = wrapperView.frame.width
    }

    private func setRoundingCorners() {
        guard let tableView = tableView, let indexPath = indexPath where tableView.style == .Grouped else {
            layer.mask = nil
            return
        }
        var roundingCorners = tableView.cardStyleSource?.roundingCornersForCardInSection(indexPath.section) ?? UIRectCorner.AllCorners
        let cornerRadius = tableView.cardStyleSource?.cornerRadiusForCardStyleTableViewCell() ?? 0
        guard roundingCorners != [] else {
            layer.mask = nil
            return
        }

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
