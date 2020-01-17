//
//  Menu.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2020/1/16.
//  Copyright © 2020 topjoy. All rights reserved.
//

import Foundation

struct Menu {
    let name: String
    let cls: AnyClass
    
    static func getData() -> [Menu] {
        return [
            Menu(name: "Views", cls: ViewsControler.self),
            Menu(name: "Layout", cls: LayoutController.self)
        ]
    }
}

