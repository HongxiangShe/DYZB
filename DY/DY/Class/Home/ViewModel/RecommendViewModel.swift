//
//  RecommendViewModel.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    
    fileprivate lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()

}

extension RecommendViewModel {
    func requestData() {
        
        // 1.请求第一部分推荐数据
        
        // 2.请求第二部分颜值数据
        
        // 3.请求后面部分游戏数据
        let param = ["limit" : "4", "offest" : "0", "time" : Date.getCurrentTime()]
        NetworkTool.loadData(type: .GET, urlStr: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { (result) in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String: AnyObject]] else {return}
            for dict in dataArr {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            print("")
        }
    }
}
