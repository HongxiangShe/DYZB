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
        // 为了调整距离左边屏幕的间距
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -10
        
        // 左侧的item
        let logoBtn = UIButton(type: .custom)
        logoBtn.setImage(UIImage(named:"homeLogoIcon"), for: .normal)
        logoBtn.sizeToFit()
        navigationItem.setLeftBarButtonItems([spaceItem, UIBarButtonItem(customView: logoBtn)], animated: false)
    }
}
