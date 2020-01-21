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
        
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        v.backgroundColor = .red
        self.view.addSubview(v)
        
        let v2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        v2.backgroundColor = .green
        // 添加子节点
        v.addSubview(v2)
        // 显示所有子节点
        print(self.view.subviews)
        // 判断是否是后代，包括子类，孙类
        print(v2.isDescendant(of: self.view))
        // 通过tag 查找当前view 和 子view
        v2.tag = 110
        let v3 = v.viewWithTag(110)
        v3?.backgroundColor = .brown
        // 移除节点
//        v3?.removeFromSuperview();
        
        let v4 = UIView(frame: CGRect(x: 25, y: 50, width: 100, height: 100))
        v4.backgroundColor = .cyan
        // 把v4 放到 v2 后面
        v.insertSubview(v4, at: 0)
        // v4 和 v2 交换层级
        v.exchangeSubview(at: 0, withSubviewAt: 1)
        v.sendSubviewToBack(v2)
        v.bringSubviewToFront(v2)
        
        // 没有提供可以一次删除全部子节点的方法
        // 可以通过循环来搞定
//        v.subviews.forEach {$0.removeFromSuperview()}
        
        // 显隐 和 透明
        v2.isHidden = true  // 隐藏之后将不接受touch事件
        v2.isHidden = false
        
        // v2.backgroundColor = nil //将透明不显示
//        v2.alpha = 0.5
        print(v2.isOpaque) // 神奇的属性
        
        // bound center
        let bv1 = UIView(frame: CGRect(x: 100, y: 300, width: 120, height: 120))
        bv1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        self.view.addSubview(bv1)
        
        let bv2 = UIView(frame: bv1.bounds.insetBy(dx: 10, dy: 10))
        bv2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
        bv1.addSubview(bv2)
        
//        bv2.bounds.size.width += 20
//        bv2.bounds.size.height += 20
        print(bv2.frame)
        print(bv2.bounds)
        print(bv2.center)
        // 在bv2 坐标系的（60，60）转为bv2的父节点bv1坐标系的位置
        let p1 = bv2.convert(bv2.center, to: bv2.superview)
        print(p1) // 70, 70
        // 在bv1 坐标系的（60, 60）转为bv2 坐标系的节点
        let p2 = bv2.convert(bv2.center, from: bv1)
        print(p2) // 50, 50
        
        // transform
        //bv1.transform = CGAffineTransform(rotationAngle: 45 * .pi / 180)
//        btn.titleLabel?.text = "旋转"
//        btn.frame = CGRect(x:100, y:440, width:50, height:20)
//        self.view.addSubview(btn)
//        bv1.transform = CGAffineTransform(scaleX: 1.8, y: 1.0)
//        bv1.transform = CGAffineTransform(translationX:  100, y: 0).rotated(by: 45 * .pi / 180)
//        bv1.transform = CGAffineTransform(rotationAngle: 45 * .pi / 180).translatedBy(x: 100, y: 0)
        
        // 连接两次变化
        let r = CGAffineTransform(rotationAngle: 45 * .pi / 180)
        let t = CGAffineTransform(translationX: 100, y: 0)
        // 先移动 再 旋转
        bv2.transform = r.concatenating(t)
        // 选旋转 再 移动
//        bv2.transform = t.concatenating(r)
        // 移除旋转的变化
        bv2.transform = r.inverted().concatenating(bv2.transform)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("--viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("--viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("--viewWillDisapper")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("--viewDidDisappear")
    }
}
