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
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var watchButtonWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 5
        coverImageView.layer.masksToBounds = true
        watchButton.setTitle("2万", for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 根据文字计算宽度
        let text: NSString = watchButton.title(for: .normal)! as NSString
        let size = CGSize(width: 900, height: 15)
        let dic = [NSFontAttributeName : UIFont.systemFont(ofSize: 10)]
        let strSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context: nil).size
        
        watchButtonWidthConstraint.constant = 10 + 10 + strSize.width // 其中第一个10为图片的宽度,第二个10为间距
        
    }

}