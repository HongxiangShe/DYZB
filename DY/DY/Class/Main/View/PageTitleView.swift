//
//  PageTitleView.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    fileprivate var titles: [String]
    
    fileprivate var selectedBtn: UIButton?
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()

    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension PageTitleView {
    
    fileprivate func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = self.bounds
        
        setupLabels()
        
    }
    
    fileprivate func setupLabels() {
        
        let width = self.bounds.size.width / CGFloat(titles.count)
        let height = self.bounds.size.height
        let btnY: CGFloat = 0
        var btnX: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            let btn = UIButton(type:.custom)
            btnX = CGFloat(index) * width
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.frame = CGRect(x: btnX, y: btnY, width: width, height: height)
            scrollView.addSubview(btn)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
            
            if (index == 0) {
                selectedBtn = btn
                btn.isSelected = true
            }
        }
    }
    
}


extension PageTitleView {
    @objc fileprivate func btnClick(button: UIButton) {
        guard button != selectedBtn else {
            return
        }
    }
}

