//
//  ViewsController.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2020/1/17.
//  Copyright © 2020 topjoy. All rights reserved.
//

import Foundation
import UIKit

class ViewsControler : UIViewController {
    
    override func viewDidLoad() {
        
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        v.backgroundColor = .red
        self.view.addSubview(v)
        
    }
}
