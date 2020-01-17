//
//  ViewController.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2019/12/20.
//  Copyright © 2019 topjoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var menuList: [Menu] = Menu.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = UIScreen.main.bounds
        tableView.allowsSelection = true
        
        self.view.addSubview(tableView)
        // 注册自定义的cell
        tableView.register(CompCell.self, forCellReuseIdentifier: "CompCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = menuList[indexPath.row].name
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select index: \(indexPath.row)");
        let cls: UIViewController.Type = menuList[indexPath.row].cls as! UIViewController.Type
        let controller = cls.init()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

