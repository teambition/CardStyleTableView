//
//  WeakObjectContainer.swift
//  CardStyleTableView
//
//  Created by Xin Hong on 16/7/19.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

class WeakObjectContainer {
    weak var object: AnyObject?

    init(object: AnyObject?) {
        self.object = object
    }
}
