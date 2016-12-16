//
//  PageContentView.swift
//  DY
//
//  Created by 佘红响 on 16/12/15.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

// MARK: - PageContentViewDelegate
protocol PageContentViewDelegate: class {
    func pageContentViewScrollWithCollectionView(contentView: PageContentView, collectionView: UICollectionView);
}

fileprivate let contentCellID = "contentCellID"
class PageContentView: UIView {
    
    // MARK: - 自定义属性
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?   // 避免循环引用
    weak var delegate: PageContentViewDelegate?
    
    // MARK: - 懒加载方法
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI
fileprivate extension PageContentView {
    fileprivate func setupUI() {
        guard let parentVC = parentViewController else {
            return
        }
        
        for chirldVC in childVCs {
            parentVC.addChildViewController(chirldVC)
        }
        
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource { 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:contentCellID , for: indexPath)
        
        // 清除cell中contentView的subviews
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let chirldVC = childVCs[indexPath.item]
        chirldVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chirldVC.view)
        return cell
    }
}

// MARK: - 暴露给外面的方法
extension PageContentView {
    func scrollContentViewWithIndex(index: Int) {
//        collectionView.setContentOffset(CGPoint(x: CGFloat(index) * kScreenWidth, y: 0), animated: false)
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension PageContentView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.pageContentViewScrollWithCollectionView(contentView: self, collectionView: collectionView)
    }
}
