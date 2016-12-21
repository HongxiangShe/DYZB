//
//  RecommendViewController.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderID = "kHeaderID"

fileprivate let kCellMargin: CGFloat = 5
fileprivate let kCellWidth: CGFloat = (kScreenWidth - kCellMargin) / 2
fileprivate let kNormalCellHeight: CGFloat = kCellWidth * 3 / 4
fileprivate let kPrettyCellHeight: CGFloat = kCellWidth * 4 / 3
fileprivate let kHeaderHeight: CGFloat = 50

class RecommendViewController: UIViewController {
    
    // VM层
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
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
//        layout.itemSize = CGSize(width: kCellWidth, height: kNormalCellHeight)
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
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorGroup = recommendVM.anchorGroups[section]
        return anchorGroup.anchors.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        if (indexPath.section == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            cell.anchor = anchor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.anchor = anchor
            return cell
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeCollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kCellWidth, height: kPrettyCellHeight)
        }
        
        return CGSize(width: kCellWidth, height: kNormalCellHeight)
    }
    
}

// MARK: - 加载数据
extension RecommendViewController {
    func loadData() {
        recommendVM.requestData {
            self.collectionView?.reloadData()
        }
    }
}
