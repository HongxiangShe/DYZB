//
//  HomeViewController.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

// MARK: - 设置UI
extension HomeViewController {
    
    fileprivate func setupUI() {
        setupNav()
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
