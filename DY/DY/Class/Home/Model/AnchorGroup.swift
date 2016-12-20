//
//  AnchorGroup.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    var room_list: [[String: AnyObject]]?
    var tag_name: String = ""
    var icon_url: String = "home_header_normal"
    fileprivate lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
