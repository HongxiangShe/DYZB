//
//  NetworkTool.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTool {
    
    class func requestData(type: MethodType, urlStr: String, parameters: [String: String]?=nil, finishedCallBack: @escaping (_ result: AnyObject)->()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlStr, method: method, parameters: parameters).responseJSON { response in
            
            guard let result =  response.result.value else {
                print(response.result.error)
                return
            }
            
            finishedCallBack(result as AnyObject)
        }
    }

}
