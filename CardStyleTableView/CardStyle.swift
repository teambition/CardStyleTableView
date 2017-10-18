//
//  CardStyle.swift
//  CardStyleTableView
//
//  Created by 洪鑫 on 2017/10/17.
//  Copyright © 2017年 Teambition. All rights reserved.
//

import UIKit

public struct CardStyle {
    public static func setup() {
        UITableView.cardStyle_swizzle()
        UITableViewCell.cardStyle_swizzle()
    }
}
