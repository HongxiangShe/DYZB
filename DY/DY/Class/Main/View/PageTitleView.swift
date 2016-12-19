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
fileprivate let kNormarlColor: (CGFloat, CGFloat, CGFloat) = (40, 40, 40)
fileprivate let kSelectorColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
fileprivate let btnSelectorColor = UIColor(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
fileprivate let btnNormalColor = UIColor(r: kNormarlColor.0, g: kNormarlColor.1, b: kNormarlColor.2)

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
            btn.setTitleColor(btnNormalColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.frame = CGRect(x: btnX, y: btnY, width: width, height: height)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
            scrollView.addSubview(btn)
            titleButtons.append(btn)
            
            if (index == 0) {
                selectedBtn = btn
                btn.setTitleColor(btnSelectorColor, for: .normal)
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
        button.setTitleColor(btnSelectorColor, for: .normal)
        selectedBtn?.setTitleColor(btnNormalColor, for: .normal)
        selectedBtn = button
        delegate?.pageTitleViewClickWithButton(titleView: self, button: button)
    }
}

// MARK: - 暴露给外面的方法
extension PageTitleView {
    
    func titleViewWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 获取按钮
        let sourceButton = titleButtons[sourceIndex]
        let targetButton = titleButtons[targetIndex]
        
        // 处理指示器的逻辑
        let moveTotalX = targetButton.frame.origin.x - sourceButton.frame.origin.x
        let moveX = moveTotalX * progress
        lineView.center.x = sourceButton.center.x + moveX
        
        // 处理颜色转换以及按钮的选中效果
        let colorDelta: (CGFloat, CGFloat, CGFloat) = ((kSelectorColor.0-kNormarlColor.0)*progress, (kSelectorColor.1-kNormarlColor.1)*progress, (kSelectorColor.2-kNormarlColor.2)*progress)
        let sourceColor = UIColor(r: kSelectorColor.0 - colorDelta.0, g: kSelectorColor.1 - colorDelta.1, b: kSelectorColor.2 - colorDelta.2)
        let targetColor = UIColor(r: kNormarlColor.0 + colorDelta.0, g: kNormarlColor.1 + colorDelta.1, b: kNormarlColor.2 + colorDelta.2)
        
        if (sourceButton != targetButton) {
            sourceButton.setTitleColor(sourceColor, for: .normal)
            targetButton.setTitleColor(targetColor, for: .normal)
        } else {
            selectedBtn = sourceButton
        }
    }
    
//    func setCenterXWithOffsetX(offsetX: CGFloat, totalWidth: CGFloat) {
//        
//        guard offsetX >= 0 && offsetX <= (totalWidth - kScreenWidth) else {
//            return
//        }
//        
//        let centerX = kScreenWidth / totalWidth * offsetX + (titleButtons.first?.center.x)!;
//        UIView.animate(withDuration: 0.25) {
//            self.lineView.center = CGPoint(x: centerX, y: self.lineView.center.y)
//        }
//    }
//    
//    func selectTitleButton(offsetX: CGFloat) {
//        
//        let index = Int(offsetX / kScreenWidth)
//        let button = titleButtons[index]
//        guard button != selectedBtn else {
//            return
//        }
//        
//        button.isSelected = true
//        selectedBtn?.isSelected = false
//        selectedBtn = button
//        
//    }
}

