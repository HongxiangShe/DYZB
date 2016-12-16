//
//  PageTitleView.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

// MARK: - PageTitleViewDelegate
protocol PageTitleViewDelegate: class {
    
    func pageTitleViewClickWithButton(titleView: PageTitleView, button: UIButton)
}

fileprivate let kScrollLineH: CGFloat = 3

class PageTitleView: UIView {
    
    // MARK: - 自定义属性
    fileprivate var titles: [String]?
    fileprivate var selectedBtn: UIButton?
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 懒加载
    fileprivate lazy var titleButtons: [UIButton] = [UIButton]()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.orange
        return lineView
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
fileprivate extension PageTitleView {
    
    /// 初始化方法
    fileprivate func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = self.bounds
        
        setupButtons()
        setupScrollLine()
        
    }
    
    /// 初始化Buttons
    fileprivate func setupButtons() {
        
        guard let titleArr = titles , titleArr.count > 0  else {
            return
        }
        
        let width = self.bounds.size.width / CGFloat(titleArr.count)
        let height = self.bounds.size.height
        let btnY: CGFloat = 0
        var btnX: CGFloat = 0
        
        for (index, title) in titleArr.enumerated() {
            let btn = UIButton(type:.custom)
            btn.tag = index
            btnX = CGFloat(index) * width
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.frame = CGRect(x: btnX, y: btnY, width: width, height: height)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
            scrollView.addSubview(btn)
            titleButtons.append(btn)
            
            if (index == 0) {
                selectedBtn = btn
                btn.isSelected = true
            }
        }
    }
    
    /// 初始化底线
    fileprivate func setupScrollLine() {
        scrollView.insertSubview(lineView, at: 10)
        
        guard let firstBtn = titleButtons.first else {
            return
        }
        
        // 取出button中titleLabel的宽度
        guard let titleLabel = firstBtn.titleLabel else {
            return
        }
        titleLabel.sizeToFit()
        let lineViewWidth: CGFloat = titleLabel.frame.size.width;
        
        lineView.frame = CGRect(x: 0, y: frame.size.height - kScrollLineH , width: lineViewWidth + 8, height: kScrollLineH)
        lineView.center = CGPoint(x: firstBtn.center.x, y: lineView.center.y)
    }
    
}


// MARK: - title按钮的点击方法
fileprivate extension PageTitleView {
    
    /// 按钮的点击方法
    @objc fileprivate func btnClick(button: UIButton) {
        guard button != selectedBtn else {
            return
        }
        button.isSelected = true
        selectedBtn?.isSelected = false
        selectedBtn = button
        
//        UIView.animate(withDuration: 0.25) { [weak self] in
//            self?.lineView.center = CGPoint(x: button.center.x, y: (self?.lineView.center.y)!)
//            print("centerX:\(self?.lineView.center)")
//        }
        
        delegate?.pageTitleViewClickWithButton(titleView: self, button: button)
    }
}

// MARK: - 暴露给外面的方法
extension PageTitleView {
    func setCenterXWithOffsetX(offsetX: CGFloat, totalWidth: CGFloat) {
        
        guard offsetX >= 0 && offsetX <= (totalWidth - kScreenWidth) else {
            return
        }
        
        let centerX = kScreenWidth / totalWidth * offsetX + (titleButtons.first?.center.x)!;
        UIView.animate(withDuration: 0.25) {
            self.lineView.center = CGPoint(x: centerX, y: self.lineView.center.y)
        }
        
        for btn in titleButtons {
            print("btn.center.x:\(btn.center.x)         centerX:\(centerX)")
            if (btn.center.x == centerX) {
                btn.isSelected = true
                selectedBtn?.isSelected = false
                selectedBtn = btn
            }
        }
//        let index = Int(offsetX / kScreenWidth)
//        titleButtons[index].isSelected = true
//        selectedBtn?.isSelected = false
//        selectedBtn = titleButtons[index]
    }
}

