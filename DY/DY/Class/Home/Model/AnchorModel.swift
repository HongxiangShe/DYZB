//
//  AnchorModel.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    var room_id: Int = 0
    var vertical_src: String = ""
    var isVertical: Int = 0
    var room_name: String = ""
    var nickname: String = ""
    var online: Int = 0
    var anchor_city: String = ""
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
