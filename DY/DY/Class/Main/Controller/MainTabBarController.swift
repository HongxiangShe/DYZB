//
//  MainTabBarController.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class MainTabBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addChilds()
    }

}

// MARK: - 设置UI
extension MainTabBarController {
    
    fileprivate func setupUI() {
//        view.backgroundColor = UIColor.white
    }

}

// MARK: - 添加子控制器
extension MainTabBarController {
    
    fileprivate func addChilds() {
        
        let homeVC = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateInitialViewController()!
        addChildVC(normalImage: "tabHome", highlightedImage: "tabHomeHL", title:"首页", childViewController: homeVC)
        
        let liveVC = UIStoryboard(name: "LiveViewController", bundle: nil).instantiateInitialViewController()!
        addChildVC(normalImage: "tabLiving", highlightedImage: "tabLivingHL", title:"直播", childViewController: liveVC)
        
        let followVC = UIStoryboard(name: "FollowViewController", bundle: nil).instantiateInitialViewController()!
        addChildVC(normalImage: "tabFocus", highlightedImage: "tabFocusHL", title:"关注", childViewController: followVC)
        
        let profileVC = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateInitialViewController()!
        addChildVC(normalImage: "tabMine", highlightedImage: "tabMineHL", title:"我的", childViewController: profileVC)
    }
    
    fileprivate func addChildVC(normalImage:String, highlightedImage:String, title:String, childViewController:UIViewController) {
        
        let nav = MainNavigationController()
        nav.tabBarItem.image = UIImage(named: normalImage)
        nav.tabBarItem.selectedImage = UIImage(named: highlightedImage)
        nav.tabBarItem.title = title
        nav.addChildViewController(childViewController)
        addChildViewController(nav)
    }
}
