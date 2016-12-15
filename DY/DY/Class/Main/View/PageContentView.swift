//
//  PageContentView.swift
//  DY
//
//  Created by 佘红响 on 16/12/15.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

fileprivate let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    // MARK: - 自定义属性
    fileprivate var childVCs: [UIViewController]
    fileprivate var parentViewController: UIViewController
    
    // MARK: - 懒加载方法
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
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
        for chirldVC in childVCs {
            parentViewController.addChildViewController(chirldVC)
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
