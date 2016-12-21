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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var smallIconImageView: UIImageView!

    @IBOutlet weak var watchButtonWidthConstraint: NSLayoutConstraint!
    
    var anchor: AnchorModel? {
        didSet {
            if (anchor?.online)! < 10000 {
                watchButton .setTitle("\((anchor?.online)!)", for: .normal)
            } else {
                let count = String(format: "%.1f", CGFloat((anchor?.online)!) / 10000)
                watchButton .setTitle("\(count)万", for: .normal)
            }
            nameLabel.text = anchor?.nickname
            roomNameLabel.text = anchor?.room_name
            coverImageView.kf.setImage(with: URL(string: (anchor?.vertical_src)!), placeholder: UIImage(named: "live_cell_default_phone")) { (_, _, _, _) in
                self.smallIconImageView.image = UIImage(named: "home_live_player_phone")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 5
        coverImageView.layer.masksToBounds = true
//        watchButton.setTitle("2万", for: .normal)
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
