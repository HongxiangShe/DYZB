//
//  CollectionViewNormalCell.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 5
        coverImageView.layer.masksToBounds = true
    }

}
