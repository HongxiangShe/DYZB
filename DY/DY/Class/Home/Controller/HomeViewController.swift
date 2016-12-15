//
//  HomeViewController.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

fileprivate let kTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView : PageTitleView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        return titleView
    }()
    
    fileprivate lazy var contentView : PageContentView = {
        let frame = CGRect(x: 0, y: kTitleViewHeight, width: kScreenWidth, height: kScreenHeight - kTopBarH - kTitleViewHeight - kTabBarH)
        var vcs = [UIViewController]()
        
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b:CGFloat(arc4random_uniform(255)))
            vcs.append(vc)
        }
        
        let contentView = PageContentView(frame: frame, childVCs: vcs, parentViewController: self)
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    
}

// MARK: - 设置UI
extension HomeViewController {
    
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        setupNav()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(contentView)
    }
    
    fileprivate func setupNav() {
        // 左侧的items
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)    // 为了调整距离左边屏幕的间距
        spaceItem.width = -10
        let leftItem = UIBarButtonItem(imageName:"homeLogoIcon", highImageName:"", size:.zero)
        navigationItem.leftBarButtonItems = [spaceItem, leftItem]
        
        // 右侧的items
        let size = CGSize(width: 40, height: 40)
        let searchBtn = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let scanBtn = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        let viewHistoryBtn = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let siteMessageBtn = UIBarButtonItem(imageName: "siteMessageHome", highImageName: "siteMessageHomeHL", size: size)
        navigationItem.rightBarButtonItems = [searchBtn, scanBtn, viewHistoryBtn, siteMessageBtn]
        
    }
}
