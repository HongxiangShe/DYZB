//
//  Date+Extension.swift
//  DY
//
//  Created by 佘红响 on 2016/12/20.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let now = Date()
        let interval = Int(now.timeIntervalSince1970)
        return "\(interval)"
    }
    
}
