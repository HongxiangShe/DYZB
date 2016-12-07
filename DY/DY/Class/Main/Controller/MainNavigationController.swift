//
//  MainNavigationController.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
    }

}

// MARK: - 设置UI
extension MainNavigationController {
    
    fileprivate func setupUI() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: .default)
    }
}
