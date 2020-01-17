//
//  CompCell.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2019/12/20.
//  Copyright © 2019 topjoy. All rights reserved.
//

import UIKit

class CompCell: UITableViewCell {
    
    var nameLabel: UITextView!;
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        nameLabel = UITextView()
//        nameLabel.text = "myCustom Cell"
//        nameLabel.frame = CGRect( x: 0, y: 0, width: 200, height: 50 )
//        self.view.addSubview(nameLabel)
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    func makeUI () {
        nameLabel = UITextView()
        nameLabel.text = "myCustom Cell"
        nameLabel.frame = CGRect( x: 0, y: 0, width: 200, height: 50 )
        nameLabel.isEditable = false
        self.addSubview(nameLabel)
    }
    
    func setName(name: String) {
        nameLabel.text = name
    }
}
