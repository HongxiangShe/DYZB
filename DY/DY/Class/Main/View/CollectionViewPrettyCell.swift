//
//  CollectionViewPrettyCell.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var watchButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var watchButton: WatchButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            if (anchor?.online)! < 10000 {
                watchButton .setTitle("\((anchor?.online)!)", for: .normal)
            } else {
                let count = String(format: "%.1f", CGFloat((anchor?.online)!) / 10000)
                watchButton .setTitle("\(count)万", for: .normal)
            }
            iconImageView.kf.setImage(with: URL(string: (anchor?.vertical_src)!), placeholder: UIImage(named: "live_cell_default_phone")) { (_, _, _, _) in
                
            }
            nameLabel.text = anchor?.nickname
            cityLabel.text = anchor?.anchor_city
        }
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
