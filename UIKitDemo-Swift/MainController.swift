//
//  MainController.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2020/1/17.
//  Copyright © 2020 topjoy. All rights reserved.
//

import Foundation
import UIKit

class MainController: UITableViewController {
    
    var menuList: [Menu] = Menu.getData()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = menuList[indexPath.row].name
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select index: \(indexPath.row)");
        let cls: UIViewController.Type = menuList[indexPath.row].cls as! UIViewController.Type
        let controller = cls.init()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
