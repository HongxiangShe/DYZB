//
//  HomeCollectionHeaderView.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group: AnchorGroup? {
        didSet {
            headerImageView.image = UIImage(named: (group?.icon_name)!)
            titleLabel.text = group?.tag_name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
