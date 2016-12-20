//
//  RecommendViewModel.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    fileprivate var prettyGroup: AnchorGroup?
    fileprivate var hotGroup: AnchorGroup?

}

extension RecommendViewModel {
    func requestData(finish: @escaping ()->()) {
        
        let param = ["limit" : "4", "offest" : "0", "time" : Date.getCurrentTime()]
        
        let group = DispatchGroup()

        group.enter()
        // 1.请求第一部分推荐数据
        NetworkTool.loadData(type: .GET, urlStr: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String: AnyObject]] else {return}
            
            let hotGroup = AnchorGroup()
            hotGroup.tag_name = "热门"
            hotGroup.icon_name = "home_header_hot"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                hotGroup.anchors.append(anchor)
            }
            self.hotGroup = hotGroup
            
            group.leave()
        }
        
        
        
        group.enter()
        // 2.请求第二部分颜值数据
        NetworkTool.loadData(type: .GET, urlStr: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: param) { (result) in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String: AnyObject]] else {return}
            
            let prettyGroup = AnchorGroup()
            prettyGroup.tag_name = "颜值"
            prettyGroup.icon_name = "home_header_phone"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                prettyGroup.anchors.append(anchor)
            }
            self.prettyGroup = prettyGroup
            group.leave()
        }
        
        group.enter()
        // 3.请求后面部分游戏数据
        NetworkTool.loadData(type: .GET, urlStr: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { (result) in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String: AnyObject]] else {return}
            for dict in dataArr {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup!, at: 0)
            self.anchorGroups.insert(self.hotGroup!, at: 0)
            finish()
        }
    }
}
