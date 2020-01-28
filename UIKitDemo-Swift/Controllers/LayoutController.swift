//
//  LayoutController.swift
//  UIKitDemo-Swift
//
//  Created by topjoy on 2020/1/17.
//  Copyright © 2020 topjoy. All rights reserved.
//

/**
 * super 需要调整尺寸的情况
 * 1. app 跟随设备旋转， app 需要匹配新的顶部，新的方向，随后还要调换bounds 中的高宽的值。
 * 2. app 可能运行在不同分辨率的设备上。
 * 3. 一个通用的app 可能运在ipad 或iphone 上， app 界面需要根据运行的设备去适配屏幕尺寸
 * 4. 通过nib 创建的view 实例，例如一个viewController 的主界面或table cell 可能会自动调节尺寸，根据被放置的位置。
 * 5. view 需要响应他周边view的变化，例如：当一个导航栏显示或隐藏，界面其余部分需要去收缩或伸展来补偿。
 * 6. 多任务同时执行的时候用户可能会改变app窗口的宽度。
 *
 *layout 主要通过三个方式来实现。
 *1. 手动布局。
 *2. 自动调整尺寸， autoSizing
 *3. 自动布局。依赖constraints
 */



import Foundation
import UIKit

class LayoutController : UIViewController {
    
    var constraintsWith: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var constraintsWithout: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var vb2: UIView? = nil
    override func viewDidLoad() {
        
        // autoresizing 策略
        let v1 = UIView(frame: CGRect(x: 100, y: 111, width: 132, height: 192))
        v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 132, height: 10))
        v2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
        
        let v1b = v1.bounds
        let v3 = UIView(frame: CGRect(x: v1b.width - 20, y: v1b.height - 20, width: 20, height: 20))
        v3.backgroundColor=UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(v1)
        v1.addSubview(v2)
        v1.addSubview(v3)
        
        // subview resize 策略
        v2.autoresizingMask = .flexibleWidth
        v3.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
        v2.translatesAutoresizingMaskIntoConstraints = false
        v3.translatesAutoresizingMaskIntoConstraints = false
        // 改变superView bounds size 自适应大小
//        v1.bounds.size.width += 40
//        v1.bounds.size.height -= 40
//        v1.translatesAutoresizingMaskIntoConstraints = false
        
        // 使用autolayout   autoresizing 只支持view 和 superView 之间的关系， autoLayout 支持view 和view
        // autolayout 是对 layoutSubviews 一种功能注入
        // autolayout 是比较灵活的，一对兄弟View, 一个可以用autoresize 另一个可以是autolayout.
        // superView 可以用autoLayout , 子节点可以用，也可以不用。
        // autolayout 是通过父节点链来实现的，如果一个view 用autoLayout, 那么他的祖先节点都会变为autoLayout 布局
        
        // 首先关闭translatesAutoresizingMaskIntoConstraints
        /*
        v2.translatesAutoresizingMaskIntoConstraints = false
        v3.translatesAutoresizingMaskIntoConstraints = false
        // v2 对 v1 的约束
        v1.addConstraint(NSLayoutConstraint(item: v2, attribute: .leading, relatedBy: .equal, toItem: v1, attribute: .leading, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v2, attribute: .trailing, relatedBy: .equal, toItem: v1, attribute: .trailing, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v2, attribute: .top, relatedBy: .equal, toItem: v1,
            attribute: .top, multiplier: 1, constant: 0))
        // 设置v2的高
        v2.addConstraint(NSLayoutConstraint(item: v2, attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .notAnAttribute, multiplier: 1, constant: 20))
        
        // v3 对 v1 的约束
        v1.addConstraint(NSLayoutConstraint(item: v3, attribute: .trailing, relatedBy: .equal, toItem: v1,
                                            attribute: .trailing, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v3, attribute: .bottom, relatedBy: .equal, toItem: v1,
                                            attribute: .bottom, multiplier: 1, constant: 0))
        // v3 的宽和高
        v3.addConstraint(NSLayoutConstraint(item: v3, attribute: .width, relatedBy: .equal, toItem: nil,
                                            attribute: .notAnAttribute, multiplier: 1, constant: 20))
        v3.addConstraint(NSLayoutConstraint(item: v3, attribute: .height, relatedBy: .equal, toItem: nil,
                                            attribute: .notAnAttribute, multiplier: 1, constant: 20))
       
        v1.bounds.size.width += 40
        v1.bounds.size.height -= 40
        */
        // NSLayoutAnchor 聚焦关联约束的属性，使用方便
        /*
        NSLayoutConstraint.activate([
            v2.leadingAnchor.constraint(equalTo: v1.leadingAnchor),
            v2.trailingAnchor.constraint(equalTo: v1.leadingAnchor),
            v2.topAnchor.constraint(equalTo: v1.topAnchor),
            v2.heightAnchor.constraint(equalToConstant: 20),
            v3.widthAnchor.constraint(equalToConstant: 20),
            v3.heightAnchor.constraint(equalToConstant: 20),
            v3.trailingAnchor.constraint(equalTo: v1.trailingAnchor),
            v3.bottomAnchor.constraint(equalTo: v1.bottomAnchor)
        ])
        
        v1.bounds.size.width += 40
        v1.bounds.size.height -= 40
        */
        // 可视格式符号 visual format notation 可以实现，一句话表示和多个view 关系。
        let d = ["v2": v2, "v3": v3]
        NSLayoutConstraint.activate([
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[v2]|", options: [], metrics: nil, views: d),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[v2(20)]", options: [] , metrics: nil, views: d),
            NSLayoutConstraint.constraints(withVisualFormat: "H:[v3(20)]|", options: [], metrics: nil, views: d),
            NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(30)]|", options: [], metrics: nil, views: d)
            ].flatMap{$0})
        
        v1.bounds.size.width += 40
        v1.bounds.size.height -= 40
        
        // 实现动态布局，使用两组约束
        createSwitchButton()
        let vb1 = UIView()
        vb1.backgroundColor = .red
        vb1.translatesAutoresizingMaskIntoConstraints = false
        
        let vb2 = UIView()
        vb2.backgroundColor = .yellow
        vb2.translatesAutoresizingMaskIntoConstraints = false
        self.vb2 = vb2
        let vb3 = UIView()
        vb3.backgroundColor = .blue
        vb3.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(vb1)
        self.view.addSubview(vb2)
        self.view.addSubview(vb3)
        
        let c1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v": vb1])
        let c2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v": vb2])
        let c3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v": vb3])
        let c2With = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(500)-[v1(20)]-(20)-[v2(20)]-(20)-[v3(20)]", options: [], metrics: nil, views: ["v1": vb1, "v2": vb2, "v3": vb3])
        let c2Without = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(500)-[v1(20)]-(20)-[v3(20)]", options: [], metrics: nil, views: ["v1": vb1, "v3": vb3])

        NSLayoutConstraint.activate([c1, c3].flatMap{$0})
        
        self.constraintsWith.append(contentsOf: [c2, c2With].flatMap{$0})
        self.constraintsWithout.append(contentsOf: c2Without)
        NSLayoutConstraint.activate(self.constraintsWith)
        
        // 测试safeAreaLayoutGuide 自动调整显示safeArea里
        let vc1 = UIView()
        vc1.backgroundColor = .brown
//        vc1.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(vc1)
        vc1.translatesAutoresizingMaskIntoConstraints = false
        // 调整safearea的范围大小
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        // 设置view 自身的margin  layoutMargins 值 能够继承给子节点
        vc1.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        // 测试LayoutMargin 对子节点的影响
//        let vc3 = UIView()
//        vc3.backgroundColor = .link
//        vc3.translatesAutoresizingMaskIntoConstraints = false
//        vc1.addSubview(vc3)
//        vc3.preservesSuperviewLayoutMargins = false
//        NSLayoutConstraint.activate([
//            vc3.widthAnchor.constraint(equalToConstant: 60),
//            vc3.heightAnchor.constraint(equalToConstant: 60),
//            vc3.trailingAnchor.constraint(equalTo: vc1.layoutMarginsGuide.trailingAnchor),
//            vc3.leadingAnchor.constraint(equalTo: vc1.layoutMarginsGuide.leadingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            vc1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            vc1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            vc1.widthAnchor.constraint(equalToConstant: 100),
//            vc1.heightAnchor.constraint(equalToConstant: 100)
//        ])
        
//        let vc2 = UIView()
//        vc2.backgroundColor = .blue
//        self.view.addSubview(vc2)
//        vc2.translatesAutoresizingMaskIntoConstraints = false
////        vc2.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        NSLayoutConstraint.activate([
//            vc2.leadingAnchor.constraint(equalTo: vc1.layoutMarginsGuide.trailingAnchor),
//            vc2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            vc2.widthAnchor.constraint(equalToConstant: 100),
//            vc2.heightAnchor.constraint(equalToConstant: 100)
//        ])
        // 自定义LayoutGuide
        
        let svg = UIView()
        svg.backgroundColor = .white
        svg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(svg)
        
        NSLayoutConstraint.activate([
            svg.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            svg.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            svg.widthAnchor.constraint(equalToConstant: 200),
            svg.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let guides = [UILayoutGuide(), UILayoutGuide()]
        let views = [ createUIView(color: .green, parent: svg),
                      createUIView(color: .red, parent: svg),
//                      createUIView(color: .link, parent: svg),
                      createUIView(color: .blue, parent: svg)]
        for guide in guides {
            svg.addLayoutGuide(guide)
        }
        for view in views {
            svg.addSubview(view)
        }
        // 水平等距
        
        NSLayoutConstraint.activate([
            views[0].widthAnchor.constraint(equalToConstant: 200),
            views[1].widthAnchor.constraint(equalToConstant: 200),
            views[2].widthAnchor.constraint(equalToConstant: 200),

            views[0].heightAnchor.constraint(equalToConstant: 20),
            views[1].heightAnchor.constraint(equalToConstant: 20),
            views[2].heightAnchor.constraint(equalToConstant: 20),
        ])
        
        /*
        NSLayoutConstraint.activate([
            guides[0].topAnchor.constraint(equalTo: svg.topAnchor),
            guides[1].topAnchor.constraint(equalTo: svg.topAnchor),

            guides[0].heightAnchor.constraint(equalToConstant: 10),
            guides[1].heightAnchor.constraint(equalToConstant: 10),
            
            views[0].leadingAnchor.constraint(equalTo: svg.leadingAnchor),
            
            views[0].trailingAnchor.constraint(equalTo: guides[0].leadingAnchor),
            views[1].leadingAnchor.constraint(equalTo: guides[0].trailingAnchor),

            views[1].trailingAnchor.constraint(equalTo: guides[1].leadingAnchor),
            views[2].leadingAnchor.constraint(equalTo: guides[1].trailingAnchor),
            views[2].trailingAnchor.constraint(equalTo: svg.trailingAnchor),
            
            guides[1].widthAnchor.constraint(equalTo: guides[0].widthAnchor),
        ])
        */
        // 垂直等距
        /*
        NSLayoutConstraint.activate([
            views[0].widthAnchor.constraint(equalToConstant: 200),
            views[1].widthAnchor.constraint(equalToConstant: 200),
            views[2].widthAnchor.constraint(equalToConstant: 200),

            views[0].heightAnchor.constraint(equalToConstant: 20),
            views[1].heightAnchor.constraint(equalToConstant: 20),
            views[2].heightAnchor.constraint(equalToConstant: 20),
        ])
        

        NSLayoutConstraint.activate([
            guides[0].leadingAnchor.constraint(equalTo: svg.leadingAnchor),
            guides[1].leadingAnchor.constraint(equalTo: svg.leadingAnchor),

            guides[0].widthAnchor.constraint(equalToConstant: 10),
            guides[1].widthAnchor.constraint(equalToConstant: 10),
            
            views[0].topAnchor.constraint(equalTo: svg.topAnchor),
            
            views[0].bottomAnchor.constraint(equalTo: guides[0].topAnchor),
            views[1].topAnchor.constraint(equalTo: guides[0].bottomAnchor),

            views[1].bottomAnchor.constraint(equalTo: guides[1].topAnchor),
            views[2].topAnchor.constraint(equalTo: guides[1].bottomAnchor),
            views[2].bottomAnchor.constraint(equalTo: svg.bottomAnchor),
            
            guides[1].heightAnchor.constraint(equalTo: guides[0].heightAnchor),
        ])
        */
        // 使用stackView实现等距布局
        let sv = UIStackView(arrangedSubviews: views)
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sv)
        sv.backgroundColor = .cyan
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: svg.bottomAnchor, constant: 10),
            sv.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            sv.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
       
        
        // 测试alignmentRect
        let emijImg = CustomImageView(image: UIImage(named: "emij_happy"))
        emijImg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emijImg)
        NSLayoutConstraint.activate([
            emijImg.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            emijImg.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor)
        ])
    
        print("\(emijImg.alignmentRectInsets)")
    }

    func createSwitchButton() -> Void {
        
        let btn = UIButton(type: .system)
        btn.setTitle("change", for: .normal)
        btn.setTitle("change", for: .selected)
        btn.frame = CGRect(x: 100, y: 0, width: 40, height: 20)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        
        btn.addTarget(self, action: #selector(onBtnClicked), for: .touchDown)
    }
    
    @objc func onBtnClicked() -> Void {
        if self.vb2?.superview != nil {
            self.vb2?.removeFromSuperview()
            NSLayoutConstraint.deactivate(self.constraintsWith)
            NSLayoutConstraint.activate(self.constraintsWithout)
        } else {
            self.view.addSubview(self.vb2!)
            NSLayoutConstraint.deactivate(self.constraintsWithout)
            NSLayoutConstraint.activate(self.constraintsWith)
        }
        
    }
    
    func createUIView(color: UIColor, parent: UIView) -> UIView {
        
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.preservesSuperviewLayoutMargins = true
        parent.addSubview(view)
        return view
    }
}
