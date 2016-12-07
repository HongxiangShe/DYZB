//
//  UIBarButtonItem+Extension.swift
//  DY
//
//  Created by 佘红响 on 16/12/7.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 类扩展只能使用便利构造函数  1.convenience开头  2.在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName:String, highImageName:String = "", size:CGSize = .zero) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        self.init(customView:btn)
    }
    
    
    
}
