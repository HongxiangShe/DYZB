//
//  RecommendViewController.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderID = "kHeaderID"

fileprivate let kCellMargin: CGFloat = 5
fileprivate let kCellWidth: CGFloat = (kScreenWidth - kCellMargin) / 2
fileprivate let kCellHeight: CGFloat = kCellWidth * 3 / 4
fileprivate let kHeaderHeight: CGFloat = 50

class RecommendViewController: UIViewController {
    
    fileprivate weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView?.frame = self.view.bounds
    }

}

// MARK: - 设置UI界面
extension RecommendViewController {
    func setupUI() {
        // 创建并设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kCellWidth, height: kCellHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderHeight)
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, kCellMargin)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
        view.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
    }
}

extension RecommendViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            return 8
        } else {
            return 4
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
//        cell.contentView.backgroundColor = UIColor.green
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return headerView
    }
    
}

extension RecommendViewController: UICollectionViewDelegate {
    
}
