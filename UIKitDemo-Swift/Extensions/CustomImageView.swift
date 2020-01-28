//
//  CustomImageView.swift
//  UIKitDemo-Swift
//
//  Created by charly on 2020/1/28.
//  Copyright © 2020 topjoy. All rights reserved.
//

import Foundation
import UIKit
class CustomImageView : UIImageView {
    
    override var alignmentRectInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
        }
    }
    
}
