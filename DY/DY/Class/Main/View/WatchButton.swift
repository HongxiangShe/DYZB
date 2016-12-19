//
//  WatchButton.swift
//  DY
//
//  Created by 佘红响 on 16/12/19.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class WatchButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.origin.x = 3
        titleLabel?.frame.origin.x = (imageView?.frame.size.width)! + 6
    }

}
